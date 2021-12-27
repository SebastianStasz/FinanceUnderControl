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
}

public extension Entity where Sort.Entity == Self {
    static func fetchRequest(filteringBy filters: [Filter]? = nil, sortingBy sorts: [Sort] = []) -> FetchRequest<Self> {
        let request = nsFetchRequest(filteringBy: filters, sortingBy: sorts)
        return FetchRequest(fetchRequest: request)
    }

    static func nsFetchRequest(filteringBy filters: [Filter]? = nil, sortingBy sorts: [Sort] = []) -> NSFetchRequest<Self> {
        let sortDescriptors = sorts.map { $0.nsSortDescriptor }
        let request: NSFetchRequest<Self> = Self.nsFetchRequest(sortDescriptors: sortDescriptors)
        if let predicates = filters?.compactMap({ $0.nsPredicate }) {
            request.predicate = NSCompoundPredicate(type: .or, subpredicates: predicates)
        }
        return request
    }
}
