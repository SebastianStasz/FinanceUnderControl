//
//  BalanceIndicatorView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import SwiftUI
import FinanceCoreData

struct BalanceIndicatorView: View {

    let incomesValue: Double
    let expensesValue: Double

    private var total: Double {
        incomesValue + expensesValue
    }

    var body: some View {
        Circle()
            .stroke(lineWidth: 8)
            .opacity(0.3)
            .foregroundColor(Color.gray)
            .overlay(circleIndicator(for: .expense))
            .overlay(circleIndicator(for: .income))
            .aspectRatio(contentMode: .fit)
    }

    @ViewBuilder
    private func circleIndicator(for type: CashFlowType) -> some View {
        let isIncome = type == .income
        let trimValue = (isIncome ? incomesValue : expensesValue) / total
        let axis: CGFloat = isIncome ? 1 : 0
        let rotation: Double = isIncome ? 180 : 270
        let rotation3D: Double = isIncome ? 180 : 0

        Circle()
            .trim(from: 0.0, to: trimValue)
            .stroke(lineWidth: 8)
            .foregroundColor(type.color)
            .rotationEffect(.degrees(rotation))
            .rotation3DEffect(.degrees(rotation3D), axis: (x: axis, y: axis, z: 0))
    }
}

// MARK: - Preview

struct BalanceIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceIndicatorView(incomesValue: 78, expensesValue: 22)
            BalanceIndicatorView(incomesValue: 24.25, expensesValue: 75.75).darkScheme()
        }
        .sizeThatFits()
    }
}
