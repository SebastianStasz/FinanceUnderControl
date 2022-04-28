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
        let registrationError = DriverSubject<AuthErrorCode>()
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
        let registrationError = DriverSubject<Error>()

        emailInput.isValid.assign(to: &$isEmailValid)

        passwordInput.result()
            .map { RegisterPasswordHintVD(for: $0 ?? "") }
            .assign(to: &$passwordHintVD)

        CombineLatest(passwordInput.result(), confirmPasswordInput.result())
            .map { $0.0 == $0.1 }
            .assign(to: &$isPasswordConfirmationValid)

        binding.didConfirmRegistration
            .withLatestFrom(registrationData)
            .perform(on: self, errorTracker: registrationError) { input -> AuthDataResult? in
                guard let email = input.0, let password = input.1 else { return nil }
                return try await Auth.auth().createUser(withEmail: email, password: password)
            }
            .compactMap { $0 }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.registeredSuccessfully.send()
            }

        registrationError.sinkAndStore(on: self) {
            if let authErrorCode = AuthErrorCode(rawValue: $1._code) {
                $0.binding.registrationError.send(authErrorCode)
            }
        }
    }
}
