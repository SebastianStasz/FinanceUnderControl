//
//  CashFlowType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import Foundation
import SwiftUI

public enum CashFlowType: String, Codable, Identifiable {
    case income
    case expense

    public var id: String { rawValue }
}

public extension CashFlowType {
    var name: String {
        isIncome ? .create_cash_flow_income : .create_cash_flow_expense
    }

    var namePlural: String {
        isIncome ? .common_incomes : .common_expenses
    }

    var symbol: String {
        isIncome ? "+" : "-"
    }

    var color: Color {
        isIncome ? .accentGreen : .accentRed
    }

    private var isIncome: Bool {
        if case .income = self { return true }
        return false
    }
}
