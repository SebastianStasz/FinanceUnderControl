//
//  Sector.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI

struct Sector<Content: View>: View {

    private let title: String
    private let content: Content

    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .micro) {
            Text(title, style: .headlineSmall)
                .padding(.leading, .micro)

            VStack(spacing: .micro) {
                content
            }
        }
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
