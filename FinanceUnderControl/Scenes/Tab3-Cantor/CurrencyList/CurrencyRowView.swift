//
//  CurrencyRowView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import FinanceCoreData
import SwiftUI

struct CurrencyRowView: View {

    private let code: String
    private let name: String
    private let isOn: Bool
    private let select: Action

    init(for currency: CurrencyEntity, isOn: Bool, select: @autoclosure @escaping Action) {
        self.code = currency.code
        self.name = currency.name
        self.isOn = isOn
        self.select = select
    }

    var body: some View {
        HStack(spacing: .medium) {
            Text(code, style: .currency)
            Text(name)
        }
        .trailingAction(.radio(isOn: isOn, action: select))
        .card()
    }
}

// MARK: - Preview

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrencyRowView(for: .sampleEUR(in: PersistenceController.previewEmpty.context), isOn: true, select: ())
            CurrencyRowView(for: .sampleEUR(in: PersistenceController.previewEmpty.context), isOn: false, select: ())
        }
        .padding(.vertical, .medium)
        .asPreview()
    }
}
