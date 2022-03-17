//
//  CircleView+Selectable.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import SwiftUI
import SSUtils

private struct CircleViewSelecting<T: Equatable>: ViewModifier {
    @State private var size: CGSize = .zero
    @Binding var selection: T
    let element: T

    func body(content: Content) -> some View {
        SizeReader($size) {
            content
                .padding(size.width * 0.11)
                .overlay(selectionStroke)
                .onTapGesture(perform: select)
        }
    }

    private var selectionStroke: some View {
        Circle().strokeBorder(strokeColor, lineWidth: size.width * 0.05)
    }

    private var strokeColor: Color {
        element == selection ? .grayMedium : .clear
    }

    private func select() {
        selection = element
    }
}

extension CircleView {
    func selection<T: Equatable>(_ selection: Binding<T>, element: T) -> some View {
        self.modifier(CircleViewSelecting(selection: selection, element: element))
    }
}

// MARK: - Preview

struct CircleView_Selectable_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(color: .red).selection(.constant("o"), element: "o")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
