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
        VStack(spacing: .small) {
            Text(title, style: .headlineSmall)
                .padding(.leading, .small)

            VStack(spacing: .small) {
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
