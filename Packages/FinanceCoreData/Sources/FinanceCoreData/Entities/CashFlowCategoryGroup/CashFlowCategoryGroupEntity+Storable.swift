//
//  CashFlowCategoryGroupEntity+Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import Foundation

extension CashFlowCategoryGroupEntity: Storable {

    public struct DataModel: EntityDataModel {
        public typealias E = CashFlowCategoryGroupEntity

        let name: String
        let type: CashFlowType

        public var model: CashFlowCategoryGroupEntity.Model {
            .init(name: name, type: type)
        }

        public func getModel(from controller: PersistenceController) async -> CashFlowCategoryGroupEntity.Model {
            model
        }
    }

    public var dataModel: DataModel {
        DataModel(name: name, type: type)
    }
}
