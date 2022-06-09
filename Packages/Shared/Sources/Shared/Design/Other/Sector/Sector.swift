//
//  Sector.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI

public struct Sector<Content: View>: View {

    private let viewData: SectorVD<Content>

    public var body: some View {
        VStack {
            SectorHeader(viewData.header)
                .padding(.horizontal, .large)

            VStack(spacing: .medium) {
                Group {
                    if case .card = viewData.style {
                        viewData.content.card(style: .primary)
                    } else {
                        viewData.content
                    }
                }.padding(.horizontal, .large)
            }
        }
    }

    // MARK: - Initializers

    public init(_ viewData: SectorVD<Content>) {
        self.viewData = viewData
    }

    public init(_ title: String,
         style: SectorStyle = .clear,
         editAction: EditAction? = nil,
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(SectorVD(title, style: style, editAction: editAction, content: content))
    }
}

public extension View {
    func embedInSection(_ title: String, style: SectorStyle = .clear, editAction: EditAction? = nil) -> some View {
        Sector(title, style: style, editAction: editAction) { self }
    }
}
