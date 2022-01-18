//
//  Date+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import Foundation

extension Date {
    var monthAndYearComponents: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
}

extension Date: Identifiable {
    public var id: Int { hashValue }
}
