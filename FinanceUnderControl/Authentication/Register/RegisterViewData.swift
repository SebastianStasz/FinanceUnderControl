//
//  RegisterViewData.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Foundation

struct RegisterViewData {
    let isEmailValid: Bool
    let isPasswordValid: Bool
    let isConfirmPasswordValid: Bool

    static var initialState: RegisterViewData {
        .init(isEmailValid: false, isPasswordValid: false, isConfirmPasswordValid: false)
    }
}
