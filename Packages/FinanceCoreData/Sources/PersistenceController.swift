//
//  PersistenceController.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import CoreData
import Foundation

public final class PersistenceController {
    static let shared = PersistenceController()

    private var container: NSPersistentContainer!

    public var context: NSManagedObjectContext {
        container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name:"FinanceCoreData", managedObjectModel: getNSManagedObjectModel())

        if inMemory { container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null") }

        container.loadPersistentStores { storeDescription, error in
            guard let error = error else { return }
            fatalError("Loading persistent stores error: \(error)")
        }
    }

    private func getModelURL() -> URL {
        guard let url = Bundle.module.url(forResource:"FinanceCoreData", withExtension: "momd") else {
            fatalError("Failed to find url for the resource FinanceCoreData.momd")
        }
        return url
    }

    private func getNSManagedObjectModel() -> NSManagedObjectModel {
        guard let model = NSManagedObjectModel(contentsOf: getModelURL()) else {
            fatalError("Failed to initialize managed object model from path: \(modelURL)")
        }
        return model
    }
}
