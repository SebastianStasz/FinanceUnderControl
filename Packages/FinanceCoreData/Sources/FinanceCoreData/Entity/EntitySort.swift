//
//  EntitySort.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import CoreData
import Foundation

public protocol EntitySort {
    associatedtype Entity: NSManagedObject

    var get: SortDescriptor<Entity> { get }
}

public extension EntitySort {
    var nsSortDescriptor: NSSortDescriptor {
        NSSortDescriptor(get)
    }
}
