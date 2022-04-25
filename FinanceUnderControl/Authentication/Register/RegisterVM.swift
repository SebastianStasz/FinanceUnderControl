//
//  RegisterVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Combine
import Foundation
import FirebaseAuth
import Shared
import SSUtils
import SSValidation

final class RegisterVM: ViewModel2 {

    struct ViewBinding {
        let didConfirmEmail = DriverSubject<Void>()
        let didEnterPassword = DriverSubject<Void>()
        let didConfirmRegistration = DriverSubject<Void>()
        let registeredSuccessfully = DriverSubject<Void>()
    }

    @Published private(set) var isEmailValid = false
    @Published private(set) var passwordHintVD = RegisterPasswordHintVD(for: "")
    @Published private(set) var isPasswordConfirmationValid = false

    let binding = ViewBinding()
    let emailInput = TextInputVM(validator: .email(errorMessage: .validation_invalid_email))
    let passwordInput = TextInputVM(validator: .alwaysValid)
    let confirmPasswordInput = TextInputVM(validator: .alwaysValid)

    override func bind() {
        let registrationData = CombineLatest(emailInput.result(), passwordInput.result())
        let authError = DriverSubject<AuthErrorCode>()

        emailInput.isValid.assign(to: &$isEmailValid)

        passwordInput.result()
            .map { RegisterPasswordHintVD(for: $0 ?? "") }
            .assign(to: &$passwordHintVD)

        CombineLatest(passwordInput.result(), confirmPasswordInput.result())
            .map { $0.0 == $0.1 }
            .assign(to: &$isPasswordConfirmationValid)

        binding.didConfirmRegistration
            .withLatestFrom(registrationData)
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
//                self?.binding.dismissView.send()
            }
            .store(in: &cancellables)

//        authError.map {
//            switch $0 {
//            case .emailAlreadyInUse:
//                return "This email is already in use."
//            default:
//                return "Unknown error"
//            }
//        }
//        .assign(to: &$emailMessage)
    }
}
