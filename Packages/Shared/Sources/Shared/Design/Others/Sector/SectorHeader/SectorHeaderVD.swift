//
//  SectorHeaderVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import Foundation

public struct SectorHeaderVD {

    public let title: String
    public let editAction: EditAction?

    public init(_ title: String, editAction: EditAction? = nil) {
        self.title = title
        self.editAction = editAction
    }

    public init?(_ title: String?, editAction: EditAction?) {
        guard let title = title else { return nil }
        self.init(title, editAction: editAction)
    }
}
