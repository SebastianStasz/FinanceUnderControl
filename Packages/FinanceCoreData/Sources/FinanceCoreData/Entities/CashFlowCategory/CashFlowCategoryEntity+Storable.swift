//
//  CashFlowCategoryEntity+Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import Foundation

extension CashFlowCategoryEntity: Storable {

    public struct DataModel: EntityDataModel {
        public typealias E = CashFlowCategoryEntity

        let name: String
        let type: CashFlowType
        let icon: CashFlowCategoryIcon
        let color: CashFlowCategoryColor
        let groupName: String?

        public func getModel(from controller: PersistenceController) async -> E.Model {
            let groups = await CashFlowCategoryGroupEntity.getAll(from: controller)
            let group = groups.first(where: { $0.name == groupName })
            return .init(name: name, icon: icon, color: color, type: type, group: group)
        }
    }

    public var dataModel: DataModel {
        DataModel(name: name,
                  type: type,
                  icon: icon,
                  color: color,
                  groupName: group?.name
        )
    }
}
