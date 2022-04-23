//
//  LoginVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Foundation
import SSUtils
import SSValidation

final class LoginVM: ViewModel {

    @Published private(set) var isFormValid = false

    let emailInput = TextInputVM()
    let passwordInput = TextInputVM()

    override init() {
        super.init()

        CombineLatest(emailInput.$validationState, passwordInput.$validationState)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: &$isFormValid)
    }

    func login() {
        
    }
}
