//
//  LoginVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Foundation
import SSUtils
import SSValidation

final class LoginVM: ViewModel2 {

    struct ViewBinding {
        let didTapSignUp = DriverSubject<Void>()
    }

    @Published private(set) var isFormValid = false

    let binding = ViewBinding()
    let emailInput = TextInputVM()
    let passwordInput = TextInputVM()

    override func bind() {
        let loginData = CombineLatest(emailInput.$resultValue, passwordInput.$resultValue)

        CombineLatest(emailInput.$validationState, passwordInput.$validationState)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: &$isFormValid)

        binding.didTapSignUp
            .withLatestFrom(loginData)
    }
}
