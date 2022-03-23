//
//  CashFlowEntity+Model.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation

public extension CashFlowEntity {

    struct Model {
        public let name: String
        public let date: Date
        public let value: Double
        public let currency: CurrencyEntity
        public let category: CashFlowCategoryEntity

        public init(name: String, date: Date, value: Double, currency: CurrencyEntity, category: CashFlowCategoryEntity) {
            self.name = name
            self.date = date
            self.value = value
            self.currency = currency
            self.category = category
        }
    }
}

// MARK: - Sample Data {

extension CashFlowEntity.Model {
    static func sample1(currency: CurrencyEntity, category: CashFlowCategoryEntity) -> CashFlowEntity.Model {
        CashFlowEntity.Model(name: "Sample1", date: Date(), value: 10, currency: currency, category: category)
    }

    public static func sample(context: NSManagedObjectContext) -> CashFlowEntity.Model {
        let currency = CurrencyEntity.create(in: context, model: .pln)!
        let category = CashFlowCategoryEntity.create(in: context, model: .foodExpense)
        return CashFlowEntity.Model(name: "Bideronka shopping", date: Date(), value: 104.87, currency: currency, category: category)
    }
}
