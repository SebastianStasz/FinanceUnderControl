//
//  CashFlowEntity+Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 06/04/2022.
//

import Foundation

extension CashFlowEntity: Storable {
    public typealias EntityDataModel = DataModel

    public struct DataModel: Codable {
        let name: String
        let date: Date
        let value: Double
        let categoryName: String
        let currencyCode: String
    }

    public var dataModel: DataModel {
        DataModel(name: name,
                  date: date,
                  value: value,
                  categoryName: category.name,
                  currencyCode: currency.code
        )
    }
}
