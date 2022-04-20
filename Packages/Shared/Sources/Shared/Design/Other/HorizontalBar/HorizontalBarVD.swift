//
//  HorizontalBarVD.swift
//  Shared
//
//  Created by sebastianstaszczyk on 19/04/2022.
//

import SwiftUI

public struct HorizontalBarVD: Equatable {
    let bars: [Bar]
    let total: Double

    public init(bars: [Bar], total: Double) {
        self.bars = bars.sorted(by: { $0.value > $1.value })
        self.total = total
    }

    public struct Bar: Identifiable, Equatable {
        public let title: String
        public let value: Double
        public let color: Color

        public init(title: String, value: Double, color: Color) {
            self.title = title
            self.value = value
            self.color = color
        }

        public var id: String { title }
    }

    public static func emptyFor(numberOfBars: Int) -> HorizontalBarVD {
        HorizontalBarVD(bars: (0..<numberOfBars).map { .init(title: $0.asString, value: 0, color: .gray) }, total: 0)
    }
}

// MARK: - Sample data

extension HorizontalBarVD {
    static var sample: HorizontalBarVD {
        let bar1 = HorizontalBarVD.Bar(title: "Food", value: 205.9, color: .cyan)
        let bar2 = HorizontalBarVD.Bar(title: "Petrol", value: 435, color: .yellow)
        let bar3 = HorizontalBarVD.Bar(title: "Outfit", value: 297, color: .indigo)
        return HorizontalBarVD(bars: [bar1, bar2, bar3], total: 1000)
    }
}
