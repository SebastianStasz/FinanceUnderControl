//
//  CashFlowCategoryGroupEntity+Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import Foundation

extension CashFlowCategoryGroupEntity: Storable {
    public typealias EntityDataModel = DataModel

    public struct DataModel: Codable {
        let name: String
        let type: CashFlowType
    }

    public var dataModel: DataModel {
        DataModel(name: name, type: type)
    }
}
