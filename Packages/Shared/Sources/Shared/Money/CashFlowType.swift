//
//  CashFlowType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import Foundation
import SwiftUI

public enum CashFlowType: String, Codable, Identifiable, CaseIterable, Pickerable {
    case expense
    case income

    public var id: String { rawValue }
    public var valueName: String { namePlural }
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
        isIncome ? .mainGreen : .mainRed
    }

    private var isIncome: Bool {
        if case .income = self { return true }
        return false
    }
}
