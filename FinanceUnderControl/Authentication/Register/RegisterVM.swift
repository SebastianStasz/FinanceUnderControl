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

final class RegisterVM: ViewModel {

    struct ViewBinding {
        let navigateTo = DriverSubject<RegisterCoordinator.Destination>()
        let didConfirmRegistration = DriverSubject<Void>()
    }

    @Published private(set) var isEmailValid = false
    @Published private(set) var passwordHintVD = RegisterPasswordHintVD(for: "")
    @Published private(set) var isPasswordConfirmationValid = false

    let binding = ViewBinding()
    let emailInput = TextInputVM(validator: .email(errorMessage: .validation_invalid_email))
    let passwordInput = TextInputVM(validator: .alwaysValid)
    let confirmPasswordInput = TextInputVM(validator: .alwaysValid)

    override func commonInit() {
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
            .perform(isLoading: mainLoader, errorTracker: registrationError) { input -> AuthDataResult? in
                guard let email = input.0, let password = input.1 else { return nil }
                return try await Auth.auth().createUser(withEmail: email, password: password)
            }
            .compactMap { $0 }
            .sinkAndStore(on: self) { vm, result in
                result.user.sendEmailVerification()
                vm.binding.navigateTo.send(.registeredSuccessfully)
            }

        registrationError.sinkAndStore(on: self) {
            if let authErrorCode = AuthErrorCode.Code(rawValue: $1._code) {
                $0.binding.navigateTo.send(.registrationError(authErrorCode))
            }
        }
    }
}
