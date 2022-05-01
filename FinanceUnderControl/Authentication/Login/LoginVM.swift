//
//  LoginVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import FirebaseAuth
import Foundation
import SSUtils
import SSValidation

final class LoginVM: ViewModel2 {

    struct ViewBinding {
        let didTapSignUp = DriverSubject<Void>()
        let didTapSignIn = DriverSubject<Void>()
        let loginError = DriverSubject<AuthErrorCode>()
    }

    @Published private(set) var isFormValid = false
    @Published private(set) var passwordMessage: String?

    let binding = ViewBinding()
    let emailInput = TextInputVM()
    let passwordInput = TextInputVM()

    override func commonInit() {
        let loginData = CombineLatest(emailInput.$resultValue, passwordInput.$resultValue)
        let loginError = DriverSubject<Error>()

        CombineLatest(emailInput.$validationState, passwordInput.$validationState)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: &$isFormValid)

        binding.didTapSignIn
            .withLatestFrom(loginData)
            .perform(on: self, errorTracker: loginError) { input -> AuthDataResult? in
                guard let email = input.0, let password = input.1 else { return nil }
                return try await Auth.auth().signIn(withEmail: email, password: password)
            }
            .compactMap { $0 }
            .sinkAndStore(on: self) { vm, result in
                if !result.user.isEmailVerified {
                    vm.passwordMessage = "Email not verified."
                }
            }

        loginError.sinkAndStore(on: self) {
            if let authErrorCode = AuthErrorCode(rawValue: $1._code) {
                switch authErrorCode {
                case .wrongPassword, .invalidEmail, .missingEmail, .userNotFound:
                    $0.passwordMessage = "Invalid email or password."
                default:
                    $0.binding.loginError.send(authErrorCode)
                }
            }
        }
    }
}
