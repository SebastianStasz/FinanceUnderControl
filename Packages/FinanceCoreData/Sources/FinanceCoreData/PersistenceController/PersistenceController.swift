//
//  PersistenceController.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import CoreData
import Foundation

public final class PersistenceController {
    public static let shared = PersistenceController()

    private var container: NSPersistentContainer!

    public var context: NSManagedObjectContext {
        container.viewContext
    }

    public let backgroundContext: NSManagedObjectContext

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FinanceCoreDataModel", managedObjectModel: Self.getNSManagedObjectModel())

        if inMemory { container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null") }

        container.loadPersistentStores { _, error in
            guard let error = error else { return }
            fatalError("Loading persistent stores error: \(error)")
        }
        backgroundContext = container.newBackgroundContext()
    }

    public func save() {
        do {
            try context.save()
        } catch let error {
            fatalError("Saving context error: \(error)")
        }
    }

    private static func getModelURL() -> URL {
        guard let url = Bundle.module.url(forResource: "FinanceCoreDataModel", withExtension: "momd") else {
            fatalError("Failed to find url for the resource FinanceCoreData.momd")
        }
        return url
    }

    private static func getNSManagedObjectModel() -> NSManagedObjectModel {
        let modelURL = getModelURL()
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to initialize managed object model from path: \(modelURL)")
        }
        return model
    }
}
