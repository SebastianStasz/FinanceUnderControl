//
//  RegisterEmailView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct RegisterEmailView: BaseView {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = RegisterVM()

    var baseBody: some View {
        NavigationView {
            LabeledTextField("Email", viewModel: viewModel.emailInput, showValidation: false, keyboardType: .emailAddress)
                .asRegisterView(for: .email)
                .toolbar {
                    Toolbar.trailing(systemImage: SFSymbol.close.rawValue) { dismiss.callAsFunction() }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(viewModel)
    }
}

// MARK: - Preview

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView()
    }
}
