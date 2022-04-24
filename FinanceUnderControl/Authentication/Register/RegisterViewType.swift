//
//  RegisterViewType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import SwiftUI

enum RegisterViewType {
    case email
    case password
    case passwordConfirmation

    var title: String {
        switch self {
        case .email:
            return "Sign up"
        case .password:
            return "Password"
        case .passwordConfirmation:
            return "Pasword again"
        }
    }

    var subtitle: String {
        switch self {
        case .email:
            return "First enter your email adress, that will be used to create your account."
        case .password:
            return "It's time to set your password. Let us be sure it is safe."
        case .passwordConfirmation:
            return "Let's make sure you didn't make any typos."
        }
    }

    @ViewBuilder
    var nextView: some View {
        switch self {
        case .email:
            RegisterPasswordView()
        case .password:
            RegisterConfirmPasswordView()
        case .passwordConfirmation:
            EmptyView()
        }
    }
}
