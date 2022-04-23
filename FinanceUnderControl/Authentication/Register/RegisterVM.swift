//
//  RegisterVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Combine
import Foundation
import FirebaseAuth
import SSUtils
import SSValidation

final class RegisterVM: ViewModel {

    struct Input {
        let didTapRegister = DriverSubject<Void>()
    }

    @Published private(set) var emailMessage: String?

    let input = Input()
    let emailInput = TextInputVM(validator: .email(errorMessage: "invalid"))
    let passwordInput = TextInputVM(validator: .alwaysValid)
    let confirmPasswordInput = TextInputVM(validator: .alwaysValid)

    override init() {
        super.init()

        let loginInput = CombineLatest(emailInput.result(), passwordInput.result())
        let authError = DriverSubject<AuthErrorCode>()

        input.didTapRegister
            .withLatestFrom(loginInput)
            .startLoading(on: self)
            .await {
                guard let email = $0.0, let password = $0.1 else { return }
                try await Auth.auth().createUser(withEmail: email, password: password)
            }
            .stopLoading(on: self)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Register error: \(error)")
                    if let error = AuthErrorCode(rawValue: error._code) {
                        authError.send(error)
                    } else {
                        print("Unknown error")
                    }
                }
            } receiveValue: { [weak self] in
                print("Registered successfully")
                self?.baseAction.dismissView.send()
            }
            .store(in: &cancellables)

        authError.map {
            switch $0 {
            case .emailAlreadyInUse:
                return "This email is already in use."
            default:
                return "Unknown error"
            }
        }
        .assign(to: &$emailMessage)
    }
}
