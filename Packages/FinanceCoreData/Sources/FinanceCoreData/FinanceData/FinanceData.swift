//
//  FinanceData.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import Combine
import CoreData
import Foundation
import SSUtils

public struct FinanceData: Codable {
    public let groups: [CashFlowCategoryGroupEntity.DataModel]
    public let categories: [CashFlowCategoryEntity.DataModel]
    public let cashFlows: [CashFlowEntity.DataModel]
}

public extension FinanceData {

    init(from controller: PersistenceController) async {
        try? controller.context.save() // TODO: Is saving context needed?
        let groups = await CashFlowCategoryGroupEntity.getAll(from: controller).map { $0.dataModel }
        let categories = await CashFlowCategoryEntity.getAll(from: controller).map { $0.dataModel }
        let cashFlows = await CashFlowEntity.getAll(from: controller).map { $0.dataModel }
        self.init(groups: groups, categories: categories, cashFlows: cashFlows)
    }

    var isEmpty: Bool {
        groups.isEmpty && categories.isEmpty
    }

    var isNotEmpty: Bool {
        !isEmpty
    }
}
