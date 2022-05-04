//
//  CashFlow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import FirebaseAuth
import Foundation
import Shared
import SwiftUI

struct CashFlow: FirestoreDocument {
    let name: String
    let money: Money
    let date: Date
    let categoryId: String

    var data: [String: Any] {
        [Field.name.key: name,
         Field.amount.key: money.value,
         Field.currency.key: money.currency.rawValue,
         Field.categoryId.key: categoryId,
         Field.date.key: date]
    }

    enum Field: String, DocumentField {
        case name, amount, currency, categoryId, date
    }
}
