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

    struct Events {
        let cashFlowsChanged = DriverSubject<Void>()
        let groupingChanged = DriverSubject<Void>()
    }

    private let currencyService = CurrencyService()
    let controller: PersistenceController
    let events = Events()

    var context: NSManagedObjectContext {
        controller.context
    }

    private init() {
        FirebaseApp.configure()
        let controller = PersistenceController.previewEmpty
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
