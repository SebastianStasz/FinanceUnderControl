//
//  HStack.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

struct HStack<Content: View>: View {

    let spacing: CGFloat
    let alignment: VerticalAlignment
    let content: Content

    init(alignment: VerticalAlignment = .center,
         spacing: CGFloat = 0,
         @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.content = content()
    }

    var body: some View {
        SwiftUI.HStack(alignment: alignment, spacing: spacing) { content }
    }
}

