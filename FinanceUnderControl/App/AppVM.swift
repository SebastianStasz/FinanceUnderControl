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
    static let shared = AppVM()

    private let currencyService: CurrencyService
    let context: NSManagedObjectContext

    private init() {
        let context = PersistenceController.preview.context
        self.currencyService = CurrencyService(context: context)
        self.context = context
    }
}
