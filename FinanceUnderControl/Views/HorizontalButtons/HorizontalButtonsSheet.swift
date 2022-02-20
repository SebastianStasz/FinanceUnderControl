//
//  HorizontalButtonsSheet.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI
import SSUtils

private struct HorizontalButtonsSheet: ViewModifier {
    @State private var scrollViewArea: ScrollViewArea = .top

    let title: String
    let primaryButton: HorizontalButtons.Configuration
    let secondaryButton: HorizontalButtons.Configuration?

    func body(content: Content) -> some View {
        VStack {
            ScrollContent(scrollViewArea: $scrollViewArea) { content }
                .background(Color.backgroundPrimary)
                .asSheet(title: title)

            HorizontalButtons(primaryButton: primaryButton,
                              secondaryButton: secondaryButton,
                              shouldStandOut: shouldStandOut)
        }
    }

    private var shouldStandOut: Bool {
        scrollViewArea != .notScrollable && scrollViewArea != .bottom
    }
}

extension View {
    func horizontalButtonsScroll(
        title: String,
        primaryButton: HorizontalButtons.Configuration,
        secondaryButton: HorizontalButtons.Configuration? = nil
    ) -> some View {
        modifier(HorizontalButtonsSheet(title: title, primaryButton: primaryButton, secondaryButton: secondaryButton))
    }
}
