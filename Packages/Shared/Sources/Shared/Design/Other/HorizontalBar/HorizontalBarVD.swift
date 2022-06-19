//
//  HorizontalBarVD.swift
//  Shared
//
//  Created by sebastianstaszczyk on 19/04/2022.
//

import SwiftUI

public struct HorizontalBarVD: Equatable {
    public let bars: [Bar]
    public let total: Decimal
    public let currency: Currency

    public init(bars: [Bar], total: Decimal, currency: Currency) {
        self.bars = bars.sorted(by: { $0.value > $1.value })
        self.total = total
        self.currency = currency
    }

    public struct Bar: Identifiable, Equatable {
        public let title: String
        public let value: Decimal
        public let color: Color

        public init(title: String, value: Decimal, color: Color) {
            self.title = title
            self.value = value
            self.color = color
        }

        public var id: String { title }
    }
}

// MARK: - Sample data

public extension HorizontalBarVD {
    static var sample: HorizontalBarVD {
        let bar1 = HorizontalBarVD.Bar(title: "Food", value: 205.9, color: .cyan)
        let bar2 = HorizontalBarVD.Bar(title: "Petrol", value: 435, color: .yellow)
        let bar3 = HorizontalBarVD.Bar(title: "Outfit", value: 297, color: .indigo)
        return HorizontalBarVD(bars: [bar1, bar2, bar3], total: 1000, currency: .PLN)
    }
}
