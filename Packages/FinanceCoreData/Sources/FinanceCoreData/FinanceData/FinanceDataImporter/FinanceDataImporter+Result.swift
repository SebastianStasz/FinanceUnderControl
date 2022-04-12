//
//  FinanceDataImporter+Result.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import Foundation

extension FinanceDataImporter {

    public struct Result {
        public let groups: [ResultItem]
        public let categories: [ResultItem]
        public let cashFlows: [ResultItem]
    }

    public struct ResultItem: Identifiable {
        public let id = UUID()
        public let name: String
        public let willBeCreated: Bool
    }
}

public extension Collection where Element == FinanceDataImporter.ResultItem {
    var countNew: Int {
        filter { $0.willBeCreated }.count
    }
}

// MARK: - Sample data

public extension FinanceDataImporter.Result {
    static var sampleItems: [FinanceDataImporter.ResultItem] {
        [.init(name: "Food", willBeCreated: false),
         .init(name: "Hobby", willBeCreated: false),
         .init(name: "Investments", willBeCreated: true)]
    }
}
