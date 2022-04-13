//
//  MonthBalance.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import Foundation

struct MonthBalance {
    let incomesValue: Double
    let expensesValue: Double
    let currencyCode: String

    static var empty: MonthBalance {
        .init(incomesValue: 0, expensesValue: 0, currencyCode: "")
    }
}
