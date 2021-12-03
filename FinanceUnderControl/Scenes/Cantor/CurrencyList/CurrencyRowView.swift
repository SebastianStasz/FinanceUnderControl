//
//  CurrencyRowView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import SwiftUI

struct CurrencyRowView: View {

    let code: String
    let info: String

    var body: some View {
        HStack(spacing: 12) {
            Text(code).currencySymbol
            Text(info)
        }
        .infiniteWidth(alignment: .leading)
        .padding(.vertical, .medium)
        .lineLimit(1)
    }
}

extension CurrencyRowView {
    init(currency: CurrencyEntity) {
        self.init(code: currency.code, info: currency.name)
    }

    init(code: String, value: Double) {
        self.init(code: code, info: value.asString(roundToDecimalPlaces: 2))
    }
}


// MARK: - Preview

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(code: "EUR", info: "Euro")
            .previewLayout(.sizeThatFits)
    }
}
