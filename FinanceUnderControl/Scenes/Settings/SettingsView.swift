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

            Sector(.cash_flow_filter_other) {
                Navigation(.settings_language) { viewModel.binding.navigateTo.send(.appSettings) }
                LabeledPicker(.app_theme_title, elements: AppTheme.allCases, selection: $viewModel.appTheme)
            }

            Sector("Debug") {
                Navigation("Design system") { viewModel.binding.navigateTo.send(.designSystem) }
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
