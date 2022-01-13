//
//  Pickerable.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import FinanceCoreData
import Foundation

protocol Pickerable: Hashable, Identifiable {
    var valueName: String { get }
}

extension Pickerable {
    public var id: String { valueName }
}

// MARK: - Make pickerable

extension CurrencyEntity: Pickerable {
    var valueName: String { code }
}

extension CashFlowCategoryEntity: Pickerable {
    var valueName: String { name }
}

extension String: Pickerable {
    var valueName: String { self }
}
