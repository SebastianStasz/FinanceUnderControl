//
//  BaseRowView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import SwiftUI

struct BaseRowView: View {

    private let text1: String
    private let text2: String?
    private let isCurrencySymbol: Bool

    private init(text1: String, text2: String?, isCurrencySymbol: Bool = false) {
        self.text1 = text1
        self.text2 = text2
        self.isCurrencySymbol = isCurrencySymbol
    }

    var body: some View {
        HStack(spacing: 12) {
            if isCurrencySymbol {
                Text(text1).currencySymbol
            } else {
                Text(text1)
            }

            if let text2 = text2 {
                Text(text2)
            }
        }
//        .infiniteWidth(alignment: .leading)
        .lineLimit(1)
    }
}

extension BaseRowView {
    init(text1: String, text2: String? = nil) {
        self.init(text1: text1, text2: text2, isCurrencySymbol: false)
    }

    init(currency: CurrencyEntity) {
        self.init(text1: currency.code, text2: currency.name, isCurrencySymbol: true)
    }

    init(code: String, info: String) {
        self.init(text1: code, text2: info, isCurrencySymbol: true)
    }

    init(code: String, value: Double) {
        self.init(text1: code, text2: value.asString(roundToDecimalPlaces: 2), isCurrencySymbol: true)
    }
}


// MARK: - Preview

struct BaseRowView_Previews: PreviewProvider {
    static var previews: some View {
        BaseRowView(code: "EUR", info: "Euro")
            .previewLayout(.sizeThatFits)
    }
}
