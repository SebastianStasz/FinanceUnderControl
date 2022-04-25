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

    struct ViewBinding {
        let didTapSignUp = DriverSubject<Void>()
    }

    @Published private(set) var isFormValid = false

    private let coordinator: Coordinator
    let viewBinding = ViewBinding()
    let emailInput = TextInputVM()
    let passwordInput = TextInputVM()

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init()

        CombineLatest(emailInput.$validationState, passwordInput.$validationState)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: &$isFormValid)
    }

    func login() {
        
    }
}
