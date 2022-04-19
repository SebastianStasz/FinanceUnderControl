//
//  CashFlowEntity+Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 06/04/2022.
//

import Foundation
import Shared

extension CashFlowEntity: Storable {

    public struct DataModel: EntityDataModel {
        public typealias E = CashFlowEntity

        let name: String
        let date: Date
        let type: CashFlowType
        let value: Decimal
        let categoryName: String
        let currencyCode: String

        public func getModel(from controller: PersistenceController) async -> CashFlowEntity.Model {
            let categories = await CashFlowCategoryEntity.get(from: controller)
            let currencies = await CurrencyEntity.getAll(from: controller)
            let currency = currencies.first(where: { currencyCode == $0.code })! // TODO: Handle force unwrap
            let category = categories.first(where: { categoryName == $0.name && type == $0.type })! // TODO: Handle force unwrap
            return .init(name: name, date: date, value: value, currency: currency, category: category)
        }
    }

    public var dataModel: DataModel {
        DataModel(name: name,
                  date: date,
                  type: category.type,
                  value: value,
                  categoryName: category.name,
                  currencyCode: currency_.code
        )
    }
}
