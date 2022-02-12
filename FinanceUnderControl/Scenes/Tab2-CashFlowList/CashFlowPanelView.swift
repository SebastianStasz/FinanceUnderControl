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
        VStack(spacing: .medium) {
            HStack(alignment: .top, spacing: .micro) {
                Text(cashFlow.name)
                    .textBodyMedium
                    .lineLimit(2)
                Spacer()
                Text(cashFlow.date.string(format: "d MMM YYYY"))
                    .textBodyNormal
            }
            HStack(alignment: .bottom) {
                Text(cashFlow.category.name)
                    .textCase(.uppercase)
                    .font(.caption2.weight(.light))

                Spacer()

                Text("\(categoryType.symbol) \(cashFlow.value.asString) \(cashFlow.currency?.code ?? "")")
                    .foregroundColor(categoryType.color)
                    .font(.callout)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, .small)
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }

    private var categoryType: CashFlowCategoryType {
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
