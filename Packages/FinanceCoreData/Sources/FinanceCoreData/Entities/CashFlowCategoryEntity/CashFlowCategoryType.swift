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

extension CashFlowCategoryType: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryType {
        .unknown
    }
}
