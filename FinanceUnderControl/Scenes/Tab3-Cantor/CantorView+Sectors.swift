//
//  CantorView+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI

extension CantorView {

    var sectorExchangeRate: some View {
        Sector("Exchange rate") {
            Group {
                if let exchangeRate = viewModel.exchangeRateValue {
                    Text(exchangeRate)
                } else {
                    Text(noExchangeRateMessage, style: .validation)
                }
                if let exchangedMoney = viewModel.exchangedMoney {
                    Text(exchangedMoney)
                }
            }
            .formField()
        }
    }

    var sectorConvert: some View {
        Sector("Convert") {
            ListPicker(title: "From:", listView: CurrencyListView(selection: $viewModel.currencySelector.primaryCurrency))
            ListPicker(title: "To:", listView: CurrencyListView(selection: $viewModel.currencySelector.secondaryCurrency))
            LabeledInputNumber("Amount", input: $viewModel.amountOfMoneyInput, prompt: "100")
        }
    }

    @ViewBuilder
    var sectorMore: some View {
        if let currency = viewModel.currencySelector.primaryCurrency, currency.exchangeRates.isNotEmpty {
            Sector("More") {
                Navigation("All exchange rates for \(currency.code)", leadsTo: ExchangeRateListView(viewModel: .init(currencyEntity: currency)))
            }
        }
    }
}

// MARK: - Helpers

private extension CantorView {
    var noExchangeRateMessage: String {
        viewModel.isExchangeRateData
            ? "Fill in the form to display the exchange rate."
            : "Failed to load exchange rates for \(viewModel.currencySelector.primaryCurrency?.code ?? ""). Please try again later."
    }
}
