//
//  CashFlowSelection.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import FinanceCoreData
import Foundation

enum CashFlowSelection: String {
    case all
    case expenses
    case incomes

    var name: String {
        rawValue.capitalized
    }

    var type: CashFlowCategoryType? {
        switch self {
        case .all:
            return nil
        case .expenses:
            return .expense
        case .incomes:
            return .income
        }
    }
}

extension CashFlowSelection: Pickerable {
    var valueName: String { name }
}

extension CashFlowSelection: Identifiable {
    var id: String { rawValue }
}

extension CashFlowSelection: Equatable {}
extension CashFlowSelection: CaseIterable {}
