//
//  PreviewViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI
import Shared

private struct PreviewViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            content
        }
        .padding(.large)
        .background(Color.backgroundPrimary.overlay(Color.black).opacity(0.3))
        .previewLayout(.sizeThatFits)
    }
}

extension View {
    func asPreview() -> some View {
        modifier(PreviewViewModifier())
    }
}
