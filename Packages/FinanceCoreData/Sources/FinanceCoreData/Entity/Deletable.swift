//
//  Deletable.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData

public protocol Deletable: Entity {
    func delete()
}

public extension Deletable {
    func delete() {
        CoreDataHelper.delete(self, canBeDeleted: { true })
    }
}
