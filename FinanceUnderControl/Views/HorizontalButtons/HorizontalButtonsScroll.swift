//
//  HorizontalButtonsScroll.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI
import SSUtils

private struct HorizontalButtonsScroll: ViewModifier {
    @State private var scrollViewArea: ScrollViewArea = .top

    let primaryButton: HorizontalButtons.Configuration
    let secondaryButton: HorizontalButtons.Configuration?

    func body(content: Content) -> some View {
        VStack {
            SSUtils.ScrollView(scrollViewArea: $scrollViewArea) {
                content.padding(.medium)
            }
            .background(Color.backgroundPrimary)
            .asSheet(title: "Filter")

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
        primaryButton: HorizontalButtons.Configuration,
        secondaryButton: HorizontalButtons.Configuration
    ) -> some View {
        modifier(HorizontalButtonsScroll(primaryButton: primaryButton, secondaryButton: secondaryButton))
    }
}
