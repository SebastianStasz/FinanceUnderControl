//
//  Sector.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI
import Shared

struct Sector<Content: View>: View {

    private let title: String?
    private let editAction: (() -> Void)?
    private let style: SectorStyle
    private let content: Content

    init(_ title: String? = nil,
         onEdit editAction: (() -> Void)? = nil,
         style: SectorStyle = .clear,
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.editAction = editAction
        self.style = style
        self.content = content()
    }

    var body: some View {
        VStack {
            if let title = title {
                SectorHeader(title, onEdit: editAction)
            }
            VStack(spacing: .small) {
                if case .card = style {
                    content.card(style: .primary)
                } else {
                    content
                }
            }
        }
    }
}


extension Section where Parent == SectorHeader, Content: View, Footer == EmptyView {
    init(_ title: String,
         onEdit editAction: (() -> Void)?,
         content: @escaping () -> Content
    ) {
        self.init(header: SectorHeader(title, onEdit: editAction), content: content)
    }
}

// MARK: - Preview

struct Sector_Previews: PreviewProvider {
    static var previews: some View {
        SectorDSView()
    }
}
