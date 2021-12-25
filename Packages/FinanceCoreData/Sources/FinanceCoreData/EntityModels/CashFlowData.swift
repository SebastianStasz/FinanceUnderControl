//
//  CashFlowData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public struct CashFlowData {
    public let name: String
    public let category: CashFlowCategoryEntity
}


// MARK: - Sample Data {

extension CashFlowData {
    static func sample1(withCategory cashFlowCategoryEntity: CashFlowCategoryEntity) -> CashFlowData {
        CashFlowData(name: "Sample1", category: cashFlowCategoryEntity)
    }
}
