//
//  MonthAndYearPickerVD.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import Foundation

public struct MonthAndYearPickerVD: Equatable {
    public var isOn: Bool
    public var year: Int
    public var month: Int

    let yearRange: ClosedRange<Int>

    public init() {
        let year = Calendar.current.component(.year, from: .now)
        self.isOn = false
        self.year = year
        self.month = Calendar.current.component(.month, from: .now)
        self.yearRange = 2020...year + 1
    }
}
