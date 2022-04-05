//
//  CashFlowPanelView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/01/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

struct CashFlowPanelView: View {

    private let name: String
    private let date: Date
    private let categoryName: String
    private let value: Double
    private let currencyCode: String?
    private let cashFlowType: CashFlowType

    init(for cashFlow: CashFlowEntity) {
        name = cashFlow.name
        date = cashFlow.date
        categoryName = cashFlow.category.name
        value = cashFlow.value
        currencyCode = cashFlow.currency?.code
        cashFlowType = cashFlow.category.type
    }

    var body: some View {
        VStack(spacing: .large) {
            HStack(alignment: .top, spacing: .small) {
                Text(name, style: .bodyMedium)
                    .lineLimit(2)
                Spacer()
                Text(date.string(format: "d MMM YYYY"), style: .headlineSmall())
            }
            HStack(alignment: .bottom) {
                SwiftUI.Text(categoryName)
                    .textCase(.uppercase)
                    .font(.caption.weight(.light))

                Spacer()

                SwiftUI.Text("\(cashFlowType.symbol) \(value.asString) \(currencyCode ?? "")")
                    .foregroundColor(cashFlowType.color)
                    .font(.headline)
                    .fontWeight(.medium)
            }
        }
        .card()
    }
}

// MARK: - Preview

struct CashFlowPanelView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.previewEmpty.context
        let cashFlow = CashFlowEntity.createAndReturn(in: context, model: .sample(context: context))
        CashFlowPanelView(for: cashFlow)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
