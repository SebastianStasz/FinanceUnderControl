//
//  AppVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import CoreData
import FirebaseAuth
import FinanceCoreData
import SSUtils

final class AppVM {
    static let shared = AppVM()

    struct Binding {
        let didChangeAppTheme = DriverSubject<Void>()
    }

    struct Output {
        let isUserLoggedIn: Driver<Bool>
    }

    let context: NSManagedObjectContext
    let binding = Binding()
    let output: Output

    private let isUserLoggedIn = DriverState(false)

    private init() {
        context = PersistenceController.shared.context

        output = Output(isUserLoggedIn: isUserLoggedIn.removeDuplicates().asDriver)

        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isUserLoggedIn.send(user.notNil)
        }
    }
}
