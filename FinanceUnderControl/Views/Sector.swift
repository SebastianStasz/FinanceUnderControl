//
//  Sector.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI

struct Sector<Content: View>: View {

    private let title: String
    private let content: () -> Content

    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text(title)
                .textCase(.uppercase)
                .font(.callout)
                .foregroundColor(.gray)
            content()
        }
    }
}
