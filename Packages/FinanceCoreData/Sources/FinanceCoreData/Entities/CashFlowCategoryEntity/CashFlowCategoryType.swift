//
//  CashFlowCategoryType.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation
import SSUtils
import SwiftUI
import Shared

public enum CashFlowCategoryType: String {
    case income
    case expense
    case unknown
}

public extension CashFlowCategoryType {
    var name: String {
        switch self {
        case .income:
            return .create_cash_flow_income
        case .expense:
            return .create_cash_flow_expense
        case .unknown:
            return rawValue
        }
    }

    var namePlural: String {
        switch self {
        case .income:
            return .common_incomes
        case .expense:
            return .common_expenses
        case .unknown:
            return rawValue
        }
    }

    var symbol: String {
        switch self {
        case .income:
            return "+"
        default:
            return "-"
        }
    }

    var color: Color {
        switch self {
        case .income:
            return .accentGreen
        default:
            return .accentRed
        }
    }
}

extension CashFlowCategoryType: Identifiable {
    public var id: String { rawValue }
}

extension CashFlowCategoryType: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryType {
        .unknown
    }
}
