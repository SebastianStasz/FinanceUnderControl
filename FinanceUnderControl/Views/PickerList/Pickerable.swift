//
//  Pickerable.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import FinanceCoreData
import Foundation

protocol Pickerable {
    var valueName: String { get }
}

extension CurrencyEntity: Pickerable {
    var valueName: String { code }
}
