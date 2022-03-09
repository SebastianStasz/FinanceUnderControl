//
//  CashFlowCategoryGroupData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation

public struct CashFlowCategoryGroupData {
    public let name: String
    public let type: CashFlowType

    public init(name: String, type: CashFlowType) {
        self.name = name
        self.type = type
    }
}
