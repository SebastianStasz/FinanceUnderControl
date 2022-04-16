//
//  CashFlowCardView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

public struct CashFlowCardView: View {

    private let title: String
    private let date: Date
    private let money: Money
    private let type: CashFlowType
    private let icon: String
    private let iconColor: Color

    public init(title: String, date: Date, money: Money, type: CashFlowType, icon: String, iconColor: Color) {
        self.title = title
        self.date = date
        self.money = money
        self.type = type
        self.icon = icon
        self.iconColor = iconColor
    }

    public var body: some View {
        HStack(spacing: .medium) {
            CircleView(color: iconColor, image: icon)
                .padding(.micro)

            VStack(spacing: .micro) {
                Text(title, style: .bodyMedium)
                Text(date.string(format: .long), style: .footnote())
            }

            Spacer()

            MoneyView(from: money, type: type)
        }
        .frame(height: 40)
        .card()
    }
}

// MARK: - Preview

struct CashFlowCardView_Previews: PreviewProvider {
    static var previews: some View {
        let money = Money(2720.63, currency: .USD)

        Group {
            CashFlowCardView(title: "Ikea", date: .now, money: money, type: .expense, icon: "house", iconColor: .orange)
            CashFlowCardView(title: "Payment", date: .now, money: money, type: .income, icon: "bag", iconColor: .mint).darkScheme()
        }
        .sizeThatFits()
    }
}
