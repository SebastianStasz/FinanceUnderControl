//
//  MoneyView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

public struct MoneyView: View {

    private let money: Money
    private let type: CashFlowType?

    public init(from money: Money, type: CashFlowType? = nil) {
        self.money = money
        self.type = type
    }

    public var body: some View {
        SwiftUI.Text(money.asString)
            .foregroundColor(type?.color ?? .primary)
            .font(.subheadline.weight(.medium))
    }
}

struct MoneyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let money = Money(2720.63, currency: .PLN)

            VStack(spacing: .medium) {
                MoneyView(from: money)
                MoneyView(from: money, type: .income)
                MoneyView(from: money, type: .expense)
            }

            VStack(spacing: .medium) {
                MoneyView(from: money)
                MoneyView(from: money, type: .income)
                MoneyView(from: money, type: .expense)
            }
            .darkScheme()
        }
        .sizeThatFits()
    }
}
