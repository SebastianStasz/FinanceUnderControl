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
                    Text(noExchangeRateMessage, style: .footnote(.invalid))
                }
                if let exchangedMoney = viewModel.exchangedMoney {
                    Text(exchangedMoney).transition(.scale)
                }
            }
            .card()
        }
    }

    var sectorConvert: some View {
        Sector(.cantor_converter) {
            LabeledPicker(.cantor_from, elements: currencies, selection: $viewModel.currencySelector.primaryCurrency)
            LabeledPicker(.cantor_to, elements: currencies, selection: $viewModel.currencySelector.secondaryCurrency)
            LabeledTextField(.common_amount, viewModel: viewModel.amountOfMoneyInput)
        }
    }

    @ViewBuilder
    var sectorMore: some View {
        if let currency = viewModel.currencySelector.primaryCurrency, currency.exchangeRates.isNotEmpty {
            Navigation(.common_incomes) { viewModel.binding.navigateTo.send(.exchangeRateList(for: currency)) }
                .embedInSection(.common_more)
        }
    }
}

// MARK: - Helpers

private extension CantorView {
    var noExchangeRateMessage: String {
        viewModel.isFormFilled
            ? .cantor_load_exchange_rates_error_message(forCurrency: viewModel.currencySelector.primaryCurrency?.code ?? "")
            : .cantor_fill_in_form_error_message
    }
}
