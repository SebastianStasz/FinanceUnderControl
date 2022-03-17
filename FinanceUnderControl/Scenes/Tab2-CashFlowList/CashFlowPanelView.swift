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

    let cashFlow: CashFlowEntity

    var body: some View {
        VStack(spacing: .large) {
            HStack(alignment: .top, spacing: .small) {
                Text(cashFlow.name, style: .bodyMedium)
                    .lineLimit(2)
                Spacer()
                Text(cashFlow.date.string(format: "d MMM YYYY"))
            }
            HStack(alignment: .bottom) {
                Text(cashFlow.category.name)
                    .textCase(.uppercase)
                    .font(.caption2.weight(.light))

                Spacer()

                SwiftUI.Text("\(categoryType.symbol) \(cashFlow.value.asString) \(cashFlow.currency?.code ?? "")")
                    .foregroundColor(categoryType.color)
                    .font(.callout)
                    .fontWeight(.medium)
            }
        }
        .card()
    }

    private var categoryType: CashFlowType {
        cashFlow.category.type
    }
}

// MARK: - Preview

struct CashFlowPanelView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.previewEmpty.context
        let cashFlow = CashFlowEntity.create(in: context, data: .sample(context: context))
        CashFlowPanelView(cashFlow: cashFlow)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
