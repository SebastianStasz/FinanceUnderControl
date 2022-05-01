//
//  AppVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import Foundation
import CoreData
import SwiftUI
import SSUtils
import Firebase

final class AppVM {
    static let shared = AppVM()

    private let currencyService = CurrencyService()

    let context: NSManagedObjectContext

    private init() {
        context = PersistenceController.preview.context
    }

    func setupCurrencies() async {
        await currencyService.setupCurrencies(in: context)
    }
}
