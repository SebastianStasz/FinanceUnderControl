//
//  DoubleTitleViewModifier.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 22/04/2022.
//

import Shared
import SwiftUI
import SSUtils

private struct DoubleTitleViewModifier: ViewModifier {

    let title: String
    let subtitle: String

    func body(content: Content) -> some View {
        ScrollViewIfNeeded(bottomPaddingOnScroll: .large) {
            VStack(spacing: .xxlarge) {
                VStack(spacing: .micro) {
                    SwiftUI.Text(title)
                        .fontWeight(.semibold)
                        .font(.largeTitle)

                    SwiftUI.Text(subtitle)
                        .fontWeight(.semibold)
                        .font(.headline)
                }

                content.infiniteSize(alignment: .top)
            }
            .padding(.horizontal, .medium)
        }
        .background(Color.backgroundPrimary)
    }
}

extension View {
    public func doubleTitle(title: String, subtitle: String) -> some View {
        modifier(DoubleTitleViewModifier(title: title, subtitle: subtitle))
    }
}

// MARK: - Preview

struct DoubleTitleViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("View content here")
            Spacer()
        }
        .doubleTitle(title: "What cen we call you?", subtitle: "Tell us your preferred name. This is just between us.")
        .embedInNavigationView(title: "", displayMode: .inline)

        VStack {
            Text("View content here")
            Spacer()
        }
        .doubleTitle(title: "What cen we call you?", subtitle: "Tell us your preferred name. This is just between us.")
        .embedInNavigationView(title: "", displayMode: .inline)
        .darkScheme()
    }
}
