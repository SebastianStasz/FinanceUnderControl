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
        let didChangeCashFlow = DriverSubject<Void>()
    }

    let events = Events()
    let context: NSManagedObjectContext

    private init() {
        context = PersistenceController.shared.context
    }
}
