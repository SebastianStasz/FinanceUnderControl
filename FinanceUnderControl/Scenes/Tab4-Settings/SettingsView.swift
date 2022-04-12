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

    @State private var isExportDataViewShown = false
    @State private var isImportDataViewShown = false

    var body: some View {
        FormView {
            Sector(.common_categories) {
                Navigation(.common_expenses, leadsTo: CashFlowCategoryListView(type: .expense))
                Navigation(.common_incomes, leadsTo: CashFlowCategoryListView(type: .income))
            }

            Sector(.common_currencies) {
                LabeledPicker(.common_primary, elements: currencies, selection: $viewModel.primaryCurrency)
                LabeledPicker(.common_secondary, elements: currencies, selection: $viewModel.secondaryCurrency)
            }

            Sector(.settings_your_finance_data) {
                Button(action: { isExportDataViewShown = true }) {
                    Text(.common_export).card()
                }
                .buttonStyle(.plain)

                Button(action: { isImportDataViewShown = true }) {
                    Text(.common_import).card()
                }
                .buttonStyle(.plain)
            }

            Sector("Debug") {
                Navigation("Design system", leadsTo: DesignSystemView())
            }
        }
        .sheet(isPresented: $isExportDataViewShown, content: ExportFinanceDataView.init)
        .sheet(isPresented: $isImportDataViewShown, content: ImportFinanceDataView.init)
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
