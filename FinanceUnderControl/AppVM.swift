//
//  AppVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import Foundation
import CoreData

final class AppVM {
    let context: NSManagedObjectContext
    private let currencyService: CurrencyService

    init() {
        let context = PersistenceController.preview.context
        self.context = context
        self.currencyService = CurrencyService(context: context)
    }
}
