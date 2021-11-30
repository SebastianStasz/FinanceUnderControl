//
//  ExchangeRateListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import FinanceCoreData
import SwiftUI

struct ExchangeRateListView: View {

    let currency: CurrencyEntity

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(currency.exchangeRates.sorted(by: { $0.code > $1.code })) {
                    Text($0.code)
                }
            }
        }
    }
}


// MARK: - Preview

//struct ExchangeRateListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExchangeRateListView()
//    }
//}
