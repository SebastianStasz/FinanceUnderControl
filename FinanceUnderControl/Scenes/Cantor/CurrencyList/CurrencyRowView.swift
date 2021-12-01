//
//  CurrencyRowView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import SwiftUI

struct CurrencyRowView: View {

    private let code: String
    private let info: String

    init(code: String, info: String) {
        self.code = code
        self.info = info
    }

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
}


// MARK: - Preview

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(code: "EUR", info: "Euro")
            .previewLayout(.sizeThatFits)
    }
}
