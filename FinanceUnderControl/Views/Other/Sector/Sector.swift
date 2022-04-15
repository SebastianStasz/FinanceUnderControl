//
//  Sector.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import Shared
import SwiftUI

struct Sector<Content: View>: View {

    private let viewData: SectorVD<Content>

    var body: some View {
        VStack {
            SectorHeader(viewData.header)
                .padding(.horizontal, .large)

            VStack(spacing: .small) {
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

    init(_ viewData: SectorVD<Content>) {
        self.viewData = viewData
    }

    init(_ title: String,
         style: SectorStyle = .clear,
         editAction: EditAction? = nil,
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(SectorVD(title, style: style, editAction: editAction, content: content))
    }
}

extension View {
    func embedInSection(_ title: String, style: SectorStyle = .clear) -> some View {
        Sector(title, style: style) { self }
    }
}
