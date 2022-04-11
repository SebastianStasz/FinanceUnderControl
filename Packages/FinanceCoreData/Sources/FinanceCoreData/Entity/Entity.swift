//
//  Entity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import CoreData
import Foundation
import SwiftUI
import SSUtils

public protocol Entity: NSManagedObject, Identifiable {
    associatedtype Filter: EntityFilter
    associatedtype Sort: EntitySort
    associatedtype Model
}

public extension Entity where Sort.Entity == Self {

    static func asyncFetch(from controller: PersistenceController, filtering: [Filter] = [], sorting: [Sort] = []) async throws -> [Self] {
        try await Task {
            let request = nsFetchRequest(filteringBy: filtering, sortingBy: sorting)
            return try controller.backgroundContext.fetch(request)
        }
        .value
    }

    static func fetchRequest(filteringBy filters: [Filter]? = nil, sortingBy sorts: [Sort] = []) -> FetchRequest<Self> {
        let request = nsFetchRequest(filteringBy: filters, sortingBy: sorts)
        return FetchRequest(fetchRequest: request)
    }

    static func nsFetchRequest(filteringBy filters: [Filter]? = nil, sortingBy sorts: [Sort] = []) -> NSFetchRequest<Self> {
        let sortDescriptors = sorts.map { $0.nsSortDescriptor }
        let request: NSFetchRequest<Self> = Self.nsFetchRequest(sortDescriptors: sortDescriptors)
        if let predicates = filters?.compactMap({ $0.nsPredicate }) {
            request.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        }
        return request
    }
}

public extension Array where Element == EntityFilter? {
    var orNSPredicate: NSPredicate {
        map { $0?.nsPredicate }.orNSPredicate
    }

    var andNSPredicate: NSPredicate {
        map { $0?.nsPredicate }.andNSPredicate
    }
}

public extension Array where Element == NSPredicate? {
    var orNSPredicate: NSPredicate {
        compactMap { $0 }.orNSPredicate
    }

    var andNSPredicate: NSPredicate {
        compactMap { $0 }.andNSPredicate
    }
}

public extension Array where Element == NSPredicate {
    var orNSPredicate: NSPredicate {
        NSCompoundPredicate(type: .or, subpredicates: self)
    }

    var andNSPredicate: NSPredicate {
        NSCompoundPredicate(type: .and, subpredicates: self)
    }
}
