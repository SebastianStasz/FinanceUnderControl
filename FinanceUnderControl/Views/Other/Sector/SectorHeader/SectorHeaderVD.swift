//
//  SectorHeaderVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import Foundation

struct SectorHeaderVD {
    let title: String
    let editAction: EditAction?

    init(_ title: String, editAction: EditAction? = nil) {
        self.title = title
        self.editAction = editAction
    }

    init?(_ title: String?, editAction: EditAction?) {
        guard let title = title else { return nil }
        self.init(title, editAction: editAction)
    }
}
