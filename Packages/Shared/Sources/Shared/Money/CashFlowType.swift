//
//  CashFlowType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import Foundation
import SwiftUI

public enum CashFlowType: String, Codable {
    case income
    case expense
}

public extension CashFlowType {
    var name: String {
        switch self {
        case .income:
            return .create_cash_flow_income
        case .expense:
            return .create_cash_flow_expense
        }
    }

    var namePlural: String {
        switch self {
        case .income:
            return .common_incomes
        case .expense:
            return .common_expenses
        }
    }

    var symbol: String {
        switch self {
        case .income:
            return "+"
        case .expense:
            return "-"
        }
    }

    var color: Color {
        switch self {
        case .income:
            return .accentGreen
        case .expense:
            return .accentRed
        }
    }
}

extension CashFlowType: Identifiable {
    public var id: String { rawValue }
}
