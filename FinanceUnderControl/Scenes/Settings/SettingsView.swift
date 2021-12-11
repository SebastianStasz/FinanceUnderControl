//
//  SettingsView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import SwiftUI

struct SettingsView: View {

    @StateObject private var viewModel = SettingsVM()

    var body: some View {
        Form {
            Section(header: Text("Currencies")) {
                ListPicker(title: "Primary:", listView: CurrencyListView(selection: $viewModel.primaryCurrency))
                ListPicker(title: "Secondary:", listView: CurrencyListView(selection: $viewModel.secondaryCurrency))
            }
        }
    }
}


// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .embedInNavigationView(title: "Settings", displayMode: .large)
    }
}
