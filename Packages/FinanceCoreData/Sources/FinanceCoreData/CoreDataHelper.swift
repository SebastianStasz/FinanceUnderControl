//
//  CoreDataHelper.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import CoreData
import Foundation

struct CoreDataHelper {

    static func delete<T: NSManagedObject>(_ entity: T, canBeDeleted: () -> Bool) {
        if let context = entity.getContext(), canBeDeleted() {
            context.delete(entity)
        }
    }
}
