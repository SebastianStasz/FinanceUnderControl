//
//  DateFormat.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 12/02/2022.
//

import Foundation

enum DateFormat: String {
    case monthAndYear = "MMMM YYYY"
}

extension Date {
    var stringMonthAndYear: String {
        string(format: .monthAndYear)
    }
}
