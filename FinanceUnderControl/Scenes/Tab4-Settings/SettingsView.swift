//
//  SettingsView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import SSUtils
import SwiftUI

struct SettingsView: View {

    @StateObject private var viewModel = SettingsVM()

    var body: some View {
        FormView {
            Sector("Categories") {
                Navigation("Expenses", leadsTo: CashFlowCategoryListView(type: .expense))
                Navigation("Incomes", leadsTo: CashFlowCategoryListView(type: .income))
            }

            Sector("Currencies") {
                ListPicker(title: "Primary:",
                           listView: CurrencyListView(selection: $viewModel.primaryCurrency))
                ListPicker(title: "Secondary:",
                           listView: CurrencyListView(selection: $viewModel.secondaryCurrency))
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
            .embedInNavigationView(title: "Settings", displayMode: .large)
    }
}
