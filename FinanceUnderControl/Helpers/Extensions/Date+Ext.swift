//
//  Date+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import Foundation
import SSUtils

extension Date {
    var monthAndYearComponents: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }

    func string(format: DateFormat) -> String {
        string(format: format.rawValue)
    }
}

extension Date: Identifiable {
    public var id: Int { hashValue }
}
