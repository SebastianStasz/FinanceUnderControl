//
//  CashFlowCategoryEntity+Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import Foundation

extension CashFlowCategoryEntity: Storable {
    public typealias EntityDataModel = DataModel

    public struct DataModel: Encodable {
        let name: String
        let type: CashFlowType
        let icon: CashFlowCategoryIcon
        let color: CashFlowCategoryColor
        let groupName: String?
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
