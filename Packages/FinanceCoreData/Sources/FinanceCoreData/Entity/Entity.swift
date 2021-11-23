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

public protocol Entity {
    associatedtype Filter: EntityFilter
    associatedtype Sort: EntitySort
}

public extension Entity where Sort.Entity == Self {
    static func getAll(filteringBy filters: [Filter]? = nil, sortingBy sorts: [Sort] = []) -> FetchRequest<Self> {
        let request = getAllNSFetchRequest(filteringBy: filters, sortingBy: sorts)
        return FetchRequest(fetchRequest: request)
    }

    static func getAllNSFetchRequest(filteringBy filters: [Filter]? = nil, sortingBy sorts: [Sort] = []) -> NSFetchRequest<Self> {
        let sortDescriptors = sorts.map { $0.asNSSortDescriptor }
        let request: NSFetchRequest<Self> = Self.nsFetchRequest(sortDescriptors: sortDescriptors)
        if let predicates = filters?.compactMap({ $0.nsPredicate }) {
            request.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        }
        return request
    }
}
