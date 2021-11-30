//
//  PersistenceControllerPreview.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Domain
import Foundation

public extension PersistenceController {

    static var previewEmpty: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        persistenceController.save()
        return persistenceController
    }

    static var preview: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        let symbolsReponse = try! JSONDecoder().decode(SymbolsReponse.self, from: DataFile.exchangerateSymbols.data)
        CurrencyEntity.create(in: persistenceController.context, currenciesData: symbolsReponse.currencies)
//        persistenceController.save()
        return persistenceController
    }
}
