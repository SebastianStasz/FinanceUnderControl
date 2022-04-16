//
//  VStack.swift
//  
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

struct VStack<Content: View>: View {

    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: Content

    init(alignment: HorizontalAlignment = .leading,
         spacing: CGFloat = 0,
         @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.content = content()
    }

    var body: some View {
        SwiftUI.VStack(alignment: alignment, spacing: spacing) { content }
    }
}
