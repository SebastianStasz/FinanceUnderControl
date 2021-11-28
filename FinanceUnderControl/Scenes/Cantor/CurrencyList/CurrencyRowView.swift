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
    let name: String

    var body: some View {
        HStack(spacing: 12) {
            Text(code)
                .font(.system(.body, design: .monospaced))
            Text(name)
        }
    }
}

extension CurrencyRowView {
    init(currency: CurrencyEntity) {
        self.init(code: currency.code, name: currency.name)
    }
}


// MARK: - Preview

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(code: "EUR", name: "Euro")
    }
}
