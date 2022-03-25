//
//  DataFile.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import Foundation

enum DataFile {
    case exchangerateSymbols
    case exchangerateLatestEur

    var data: Data {
        try! Data(contentsOf: url) // swiftlint:disable:this force_try
    }

    private var url: URL {
        switch self {
        case .exchangerateSymbols:
            return Bundle.module.url(forResource: "ExchangerateSymbols", withExtension: "json")!
        case .exchangerateLatestEur:
            return Bundle.module.url(forResource: "ExchangerateLatestEur", withExtension: "json")!
        }
    }
}
