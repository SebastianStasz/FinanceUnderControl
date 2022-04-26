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
        let authError = DriverSubject<Error>()

        emailInput.isValid.assign(to: &$isEmailValid)

        passwordInput.result()
            .map { RegisterPasswordHintVD(for: $0 ?? "") }
            .assign(to: &$passwordHintVD)

        CombineLatest(passwordInput.result(), confirmPasswordInput.result())
            .map { $0.0 == $0.1 }
            .assign(to: &$isPasswordConfirmationValid)

        binding.didConfirmRegistration
            .withLatestFrom(registrationData)
            .flatMap { input in
                Just(input)
                    .startLoading(on: self)
                    .await { input in
                        guard let email = input.0, let password = input.1 else { return }
                        try await Auth.auth().createUser(withEmail: email, password: password)
                    }
                    .stopLoading(on: self)
                    .catch { error -> AnyPublisher<Void, Never> in
                        print(error)
                        authError.send(error)
                        return Just(nil).compactMap { $0 }.eraseToAnyPublisher()
                    }
            }
            .sink { [weak self] in
                self?.binding.registeredSuccessfully.send()
            }
            .store(in: &cancellables)

        authError.sink { [weak self] in
            if let authErrorCode = AuthErrorCode(rawValue: $0._code) {
                self?.binding.registrationError.send(authErrorCode)
            }
        }
        .store(in: &cancellables)
    }
}
