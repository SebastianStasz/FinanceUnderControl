//
//  MonthBalance.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import Foundation
import Shared

struct MonthBalance {
    let income: Money
    let expense: Money

    static var empty: MonthBalance {
        let empty = Money(0, currency: .PLN)
        return .init(income: empty, expense: empty)
    }
}
