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
        let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        let endDate = Calendar.current.date(from: endDateComponents)!
        if let startDate = startDate {
            let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
            self.startDate = Calendar.current.date(from: startDateComponents)!
        } else {
            self.startDate = Calendar.current.date(byAdding: .month, value: -1, to: endDate)!
        }
        self.endDate = endDate
    }
}
