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

    init(isOn: Bool = false, startDate: Date = Date(), endDate: Date = Date()) {
        self.isOn = isOn
        self.startDate = startDate
        self.endDate = endDate
    }
}
