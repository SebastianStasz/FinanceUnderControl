//
//  FinanceStorage+ImportResult.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 11/04/2022.
//

import Foundation

extension FinanceStorage {

    public struct ImportResult {

        public struct Item: Identifiable, Equatable {
            public let id = UUID()
            public let name: String
            public let alreadyExists: Bool
        }

        public let groups: [Item]
        public let categories: [Item]
        public let cashFlows: [Item]
    }
}

extension Collection where Element == FinanceStorage.ImportResult.Item {

    public var countNew: Int {
        onlyNew.count
    }

    private var onlyNew: [FinanceStorage.ImportResult.Item] {
        filter { !$0.alreadyExists }
    }
}

// MARK: - Sample data

public extension FinanceStorage.ImportResult {
    static var sampleItems: [Item] {
        [.init(name: "Food", alreadyExists: true),
         .init(name: "Hobby", alreadyExists: true),
         .init(name: "Investments", alreadyExists: false)]
    }
}
