//
//  MonthBalance.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import Foundation
import Shared

struct MonthBalance {
    let income: Money?
    let expense: Money?

    var isLoading: Bool {
        income.isNil || expense.isNil
    }

    static var empty: MonthBalance {
        .init(income: nil, expense: nil)
    }
}
