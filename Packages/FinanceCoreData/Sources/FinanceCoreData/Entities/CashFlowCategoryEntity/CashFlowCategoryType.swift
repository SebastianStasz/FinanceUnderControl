//
//  CashFlowCategoryType.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation
import SSUtils

public enum CashFlowCategoryType: String {
    case income
    case expense
    case unknown
}

public extension CashFlowCategoryType {
    var name: String {
        self.rawValue.capitalized
    }
}

extension CashFlowCategoryType: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryType {
        .unknown
    }
}
