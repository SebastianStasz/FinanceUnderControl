//
//  ExchangeRateListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import FinanceCoreData
import Shared
import SwiftUI
import SSUtils

struct ExchangeRateListView: View {

    @ObservedObject var viewModel: ExchangeRateListVM

    var body: some View {
        BaseList(viewModel: viewModel.listVM, viewData: viewModel.listVD, emptyTitle: "No exchange rates", emptyDescription: "There is no exchange rates for selected currency.") { exchageRate in
            HStack(spacing: .medium) {
                Text(exchageRate.code, style: .currency)
                Text(exchageRate.rateValue.formatted(for: exchageRate.currency))
            }
            .card()
        }
    }
}

// MARK: - Preview

struct ExchangeRateListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.previewEmpty.context
        let currency = CurrencyEntity.sampleEUR(in: context)
        ExchangeRateListView(viewModel: .init(currencyEntity: currency))
            .embedInNavigationView(title: "Base: EUR", displayMode: .inline)
    }
}
