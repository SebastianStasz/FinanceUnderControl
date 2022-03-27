//
//  SettingsView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import FinanceCoreData
import SSUtils
import SwiftUI
import Shared

struct SettingsView: View {

    @FetchRequest(sortDescriptors: [CurrencyEntity.Sort.byCode(.forward).nsSortDescriptor]
    ) var currencies: FetchedResults<CurrencyEntity>

    @StateObject private var viewModel = SettingsVM()

    var body: some View {
        FormView {
            Sector(.common_categories) {
                Navigation(.common_expenses, leadsTo: CashFlowCategoryListView(type: .expense))
                Navigation(.common_incomes, leadsTo: CashFlowCategoryListView(type: .income))
            }

            Sector(.common_currencies) {
                LabeledPicker(.cantor_from, elements: currencies, selection: $viewModel.primaryCurrency)
                LabeledPicker(.cantor_to, elements: currencies, selection: $viewModel.secondaryCurrency)
            }

            Sector("Debug") {
                Navigation("Design system", leadsTo: DesignSystemView())
            }
        }
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .background(Color.backgroundPrimary)
            .embedInNavigationView(title: .tab_settings_title, displayMode: .large)
    }
}
