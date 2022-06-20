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
    var elements: [T]
    let editAction: EditAction?

    init(_ title: String,
         elements: [T],
         editAction: EditAction? = nil
    ) {
        self.title = title
        self.elements = elements
        self.editAction = editAction
    }

    var header: SectorHeaderVD {
        .init(title, editAction: editAction, handleEditMode: true)
    }
}

extension ListSector: Identifiable {
    var id: String { title }
}
