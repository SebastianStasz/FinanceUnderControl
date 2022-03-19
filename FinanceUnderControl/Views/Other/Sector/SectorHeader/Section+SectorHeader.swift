//
//  Section+SectorHeader.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import SwiftUI

extension Section where Parent == SectorHeader, Content: View, Footer == EmptyView {
    init(_ title: String,
         onEdit editAction: EditAction?,
         content: @escaping () -> Content
    ) {
        let header = SectorHeader(.init(title, editAction: editAction))
        self.init(header: header, content: content)
    }
}
