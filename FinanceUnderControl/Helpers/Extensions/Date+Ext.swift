//
//  Date+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import Foundation
import SSUtils

extension Date {
    func string(format: DateFormat) -> String {
        string(format: format.rawValue)
    }
}

extension Date: Identifiable {
    public var id: Int { hashValue }
}
