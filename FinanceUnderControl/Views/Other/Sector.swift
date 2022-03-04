//
//  Sector.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI

struct SectorHeader: View {

    private let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title, style: .headlineSmall)
            .padding(.leading, .small)
            .padding(.bottom, .small)
    }
}

struct Sector<Content: View>: View {

    private let title: String
    private let content: Content

    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack {
            SectorHeader(title)
            VStack(spacing: .small) { content }
        }
    }
}

extension Section where Parent == SectorHeader, Content: View, Footer == EmptyView {
    init(sectorHeader title: String, content: @escaping () -> Content) {
        self.init(header: SectorHeader(title), content: content)
    }
}

// MARK: - Preview

struct Sector_Previews: PreviewProvider {
    static var previews: some View {
        Sector("Title") {
            Text("Content")
        }
    }
}
