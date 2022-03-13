//
//  CantorView+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import Shared

extension CantorView {

    var sectorExchangeRate: some View {
        Sector(.common_exchange_rate) {
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
            .card()
        }
    }

    var sectorConvert: some View {
        Sector(.cantor_converter) {
            ListPicker(title: .cantor_from, listView: CurrencyListView(selection: $viewModel.currencySelector.primaryCurrency))
            ListPicker(title: .cantor_to, listView: CurrencyListView(selection: $viewModel.currencySelector.secondaryCurrency))
            LabeledInputNumber(.common_amount, input: $viewModel.amountOfMoneyInput)
        }
    }

    @ViewBuilder
    var sectorMore: some View {
        if let currency = viewModel.currencySelector.primaryCurrency, currency.exchangeRates.isNotEmpty {
            Sector("More") {
                Navigation(.cantor_all_exchange_rates(forCurrency: currency.code), leadsTo: ExchangeRateListView(viewModel: .init(currencyEntity: currency)))
            }
        }
    }
}

// MARK: - Helpers

private extension CantorView {
    var noExchangeRateMessage: String {
        viewModel.isFormFilled
            ? .cantor_load_exchange_rates_error_message(forCurrency: viewModel.currencySelector.primaryCurrency?.code ?? "")
            : "Fill in the form to display the exchange rate."
    }
}
