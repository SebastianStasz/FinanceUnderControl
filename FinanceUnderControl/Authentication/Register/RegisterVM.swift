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

    let input = Input()
    let emailInput = TextInputVM()
    let passwordInput = TextInputVM()

    override init() {
        super.init()

        let loginInput = CombineLatest(emailInput.result(), passwordInput.result())

        input.didTapRegister
            .withLatestFrom(loginInput)
            .startLoading(on: self)
            .await {
                guard let email = $0.0, let password = $0.1 else { return }
                try await Auth.auth().createUser(withEmail: email, password: password)
            }
            .stopLoading(on: self)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    
                    print("Register error: \(error)")
                    self?.baseAction.dismissView.send()
                }
            } receiveValue: { [weak self] in
                print("Registered successfully")
                self?.baseAction.dismissView.send()
            }
            .store(in: &cancellables)
    }
}
