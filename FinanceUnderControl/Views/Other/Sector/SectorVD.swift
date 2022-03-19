//
//  SectorVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import SwiftUI

struct SectorVD<Content: View> {
    let header: SectorHeaderVD?
    let style: SectorStyle
    let content: Content

    init(_ title: String? = nil,
         style: SectorStyle = .clear,
         editAction: EditAction? = nil,
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.header = SectorHeaderVD(title, editAction: editAction)
        self.style = style
        self.content = content()
    }
}
