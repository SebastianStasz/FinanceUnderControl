//
//  SettingsView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import Shared
import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsVM

    var body: some View {
        FormView {
            Sector(.common_currencies) {
                LabeledPicker(.common_primary, elements: Currency.allCases, selection: $viewModel.currencySelector.primaryCurrency)
                LabeledPicker(.common_secondary, elements: Currency.allCases, selection: $viewModel.currencySelector.secondaryCurrency)
            }

            Sector("Debug") {
                Navigation("Design system") { }
            }
        }
        .navigationTitle(String.tab_settings_title)
        .closeButton { viewModel.binding.navigateTo.send(.dismiss) }
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SettingsVM(coordinator: PreviewCoordinator())
        SettingsView(viewModel: viewModel)
        SettingsView(viewModel: viewModel).darkScheme()
    }
}
