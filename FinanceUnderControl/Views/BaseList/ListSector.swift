//
//  ListSector.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/03/2022.
//

import Foundation
import Shared

struct ListSector<T: Identifiable> {
    let title: String
    let elements: [T]
    let editAction: EditAction?
    let visibleIfEmpty: Bool

    init(_ title: String,
         elements: [T],
         editAction: EditAction? = nil,
         visibleIfEmpty: Bool = false
    ) {
        self.title = title
        self.elements = elements
        self.editAction = editAction
        self.visibleIfEmpty = visibleIfEmpty
    }

    var shouldBePresented: Bool {
        elements.isNotEmpty || visibleIfEmpty
    }

    var header: SectorHeaderVD {
        .init(title, editAction: editAction)
    }
}

extension ListSector: Identifiable {
    var id: String { title }
}

// MARK: - Helpers

extension ListSector {
    static func unvisibleSector(_ elements: [T]) -> [ListSector] {
        [.init(unvisibleSectorTitle, elements: elements)]
    }

    static var unvisibleSectorTitle: String {
        "Unvisible Sector Title"
    }
}
