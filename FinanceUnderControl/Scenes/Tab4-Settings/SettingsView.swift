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

    @ObservedObject var viewModel: SettingsVM

    var body: some View {
        FormView {
            Sector(.common_categories) {
                Navigation(.common_expenses, leadsTo: CashFlowGroupingListView(type: .expense))
                Navigation(.common_incomes, leadsTo: CashFlowGroupingListView(type: .income))
            }

            Sector(.common_currencies) {
                LabeledPicker(.common_primary, elements: currencies, selection: $viewModel.primaryCurrency)
                LabeledPicker(.common_secondary, elements: currencies, selection: $viewModel.secondaryCurrency)
            }

            Sector("Debug") {
                Navigation("Design system", leadsTo: DesignSystemView())
            }
        }
        .onAppear { viewModel.bind() }
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
