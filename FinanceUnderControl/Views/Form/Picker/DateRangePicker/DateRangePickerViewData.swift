//
//  DateRangePickerViewData.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import Foundation

struct DateRangePickerViewData {
    var isOn: Bool
    var startDate: Date
    var endDate: Date

    init(isOn: Bool = false, startDate: Date? = nil, endDate: Date = Date()) {
        self.isOn = isOn
        self.startDate = startDate ?? Calendar.current.date(byAdding: .month, value: -1, to: endDate) ?? endDate
        self.endDate = endDate
    }
}

extension DateRangePickerViewData: Equatable {}
