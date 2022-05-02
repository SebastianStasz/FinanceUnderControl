//
//  CashFlow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import FirebaseAuth
import Foundation
import Shared

struct CashFlow {
    let name: String
    let money: Money
    let date: Date
    let categoryId: String

    var data: [String: Any] {
        ["name": name,
         "amount": money.value,
         "currency": money.currency.rawValue,
         "categoryId": categoryId,
         "date": date]
    }
}
