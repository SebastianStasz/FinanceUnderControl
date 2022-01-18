//
//  CantorView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import FinanceCoreData
import Shared
import SSUtils
import SwiftUI
import SSValidation

struct CantorView: View {

    @StateObject private var viewModel = CantorVM()
    @State private var exchangeRatesForCurrency: CurrencyEntity?
    @State private var isInfoAlertPresented = false

    var body: some View {
        Form {
            Section(header: Text("Exchange rate")) {
                Group {
                    if let exchangeRate = viewModel.exchangeRateValue {
                        Text(exchangeRate)
                    } else {
                        Text("Fill in the form to display the exchange rate.")
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                    if let exchangedMoney = viewModel.exchangedMoney {
                        Text(exchangedMoney)
                    }
                }
            }

            Section(header: Text("Form data")) {
                ListPicker(title: "From:", listView: CurrencyListView(selection: $viewModel.currencySelector.primaryCurrency))
                ListPicker(title: "To:", listView: CurrencyListView(selection: $viewModel.currencySelector.secondaryCurrency))

                LabeledTextField<NumberInputVM>(title: "Amount", input: $viewModel.amountOfMoneyInput, prompt: "100")
            }

            Section {
                if let currency = viewModel.currencySelector.primaryCurrency {
                    Text("All exchange rates for \(currency.code)")
                        .baseRowView(buttonType: .sheet, isBlue: true, action: showExchangeRatesFor(currency))
                }
            }
        }
        .toolbar { toolbarContent }
        .infoAlert(isPresented: $isInfoAlertPresented, message: "Exchange rates data provided by: \"exchangerate.host\"")
        .sheet(item: $exchangeRatesForCurrency) {
            ExchangeRateListView(viewModel: .init(currencyEntity: $0))
        }
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
