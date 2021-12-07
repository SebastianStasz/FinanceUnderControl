//
//  CantorView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import FinanceCoreData
import SwiftUI
import Shared
import SSUtils

struct CantorView: View {

    @StateObject private var viewModel = CantorVM()
    @State private var exchangeRatesForCurrency: CurrencyEntity?
    @State private var isInfoAlertPresented = false

    var body: some View {
        Form {
            Section(header: Text("Exchange rate")) {
                Text(viewModel.exchangeRateValue ?? "Fill in the form to display the exchange rate.")
                    .font(.subheadline)
                    .opacity(0.5)
            }

            Section(header: Text("Form data")) {
                ListPicker(title: "From:", listView: CurrencyListView(selection: $viewModel.primaryCurrency))
                ListPicker(title: "To:", listView: CurrencyListView(selection: $viewModel.secondaryCurrency))
                LabeledTextField(label: "Amount:", value: $viewModel.amountOfMoney, prompt: "100")
            }

            Section {
                if let currency = viewModel.primaryCurrency {
                    Text("All exchange rates for \(currency.code)")
                        .baseRowView(buttonType: .sheet, isBlue: true, action: showExchangeRatesFor(currency))
                }
            }
        }
        .toolbar { toolbarContent }
        .sheet(item: $exchangeRatesForCurrency) {
            ExchangeRateListView(viewModel: .init(currencyEntity: $0))
        }
        .infoAlert(isPresented: $isInfoAlertPresented, message: "Exchange rates data provided by: \"exchangerate.host\"")
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.infoCircle.name, action: showInfoAlert)
    }

    // MARK: - Interactions

    private func showExchangeRatesFor(_ currency: CurrencyEntity) {
        exchangeRatesForCurrency = currency
    }

    private func showInfoAlert() {
        isInfoAlertPresented = true
    }
}


// MARK: - Preview

struct CantorView_Previews: PreviewProvider {
    static var previews: some View {
        CantorView()
            .embedInNavigationView(title: "Cantor")
    }
}
