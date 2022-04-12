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

final class AppVM {
    static let shared = AppVM()

    private let currencyService = CurrencyService()
    let controller: PersistenceController

    var context: NSManagedObjectContext {
        controller.context
    }

    private init() {
        let controller = PersistenceController.preview
        self.controller = controller
    }

    func setupCurrencies() async {
        await currencyService.setupCurrencies(in: context)
    }

    func didChangeScenePhase(to scenePhase: ScenePhase) {
        if case .background = scenePhase {
            controller.save()
        }
    }
}
