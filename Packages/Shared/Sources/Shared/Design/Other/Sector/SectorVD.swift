//
//  SectorVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import SwiftUI

public struct SectorVD<Content: View> {
    public let header: SectorHeaderVD?
    public let style: SectorStyle
    public let content: Content

    public init(
        _ title: String,
        style: SectorStyle = .clear,
        editAction: EditAction? = nil,
        handleEditMode: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.header = SectorHeaderVD(title, editAction: editAction, handleEditMode: handleEditMode)
        self.style = style
        self.content = content()
    }
}
