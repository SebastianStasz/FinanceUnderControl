//
//  DateRangePickerViewData.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import Foundation

public struct DateRangePickerViewData: Equatable {
    public var isOn: Bool
    public var startDate: Date
    public var endDate: Date

    public init(isOn: Bool = false, startDate: Date? = nil, endDate: Date = Date()) {
        self.isOn = isOn
        self.startDate = startDate ?? Calendar.current.date(byAdding: .month, value: -1, to: endDate) ?? endDate
        self.endDate = endDate
    }
}
