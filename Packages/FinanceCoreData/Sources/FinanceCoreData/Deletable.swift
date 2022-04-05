//
//  Deletable.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData

public protocol Deletable {}

public extension Deletable where Self: NSManagedObject {
    func delete() {
        guard let context = getContext() else { return }
        context.delete(self)
    }
}
