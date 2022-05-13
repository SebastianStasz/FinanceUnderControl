//
//  PersistenceControllerPreview.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 19/04/2022.
//

import CoreData
import Foundation
import Shared

public extension PersistenceController {

    static var previewEmpty: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        persistenceController.save()
        return persistenceController
    }

    static var preview: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        persistenceController.save()
        return persistenceController
    }
}
