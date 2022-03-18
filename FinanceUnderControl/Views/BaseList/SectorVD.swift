//
//  ListSector.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/03/2022.
//

import Foundation

struct SectorVD<T: Identifiable> {
    let title: String
    let elements: [T]
    let editAction: (() -> Void)?
    let visibleIfEmpty: Bool

    init(_ title: String,
         elements: [T],
         onEdit editAction: (() -> Void)? = nil,
         visibleIfEmpty: Bool = false
    ) {
        self.title = title
        self.elements = elements
        self.editAction = editAction
        self.visibleIfEmpty = visibleIfEmpty
    }

    var isNotEmpty: Bool {
        elements.isNotEmpty
    }
}

extension SectorVD: Identifiable {
    var id: String { title }
}

// MARK: - Helpers

extension SectorVD {
    static func unvisibleSector(_ elements: [T]) -> [SectorVD] {
        [.init(unvisibleSectorTitle, elements: elements)]
    }

    static var unvisibleSectorTitle: String {
        "Unvisible Sector Title"
    }
}
