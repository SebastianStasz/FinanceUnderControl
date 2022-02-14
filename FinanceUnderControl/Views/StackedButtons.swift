//
//  StackedButtons.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import SwiftUI
import SSUtils

struct StackedButtons: ViewModifier {
    @State private var scrollViewArea: ScrollViewArea = .top

    let primaryButton: ButtonViewData
    let secondaryButton: ButtonViewData?

    func body(content: Content) -> some View {
        VStack(spacing: 0) {

            SSUtils.ScrollView(scrollViewArea: $scrollViewArea) {
                content.padding(.medium)
            }
            .background(Color.backgroundPrimary)
            .asSheet(title: "Filter")

            Divider().displayIf(shouldStandOut)

            VStack(spacing: .small) {
                BaseButton(primaryButton.title, action: primaryButton.action)

                if let secondaryButton = secondaryButton {
                    BaseButton(secondaryButton.title, action: secondaryButton.action)
                }

            }
            .padding(.horizontal, .medium)
            .padding(.top, .small)
            .paddingIfNotSafeArea(.bottom, .small)
            .background(shouldStandOut ?  Color.backgroundSecondary : Color.backgroundPrimary)
            .animation(.easeInOut(duration: 0.1))
        }
    }

    private var shouldStandOut: Bool {
        scrollViewArea != .bottom && scrollViewArea != .notScrollable
    }
}

extension View {
    func stackedButtons(primaryButton: ButtonViewData, secondaryButton: ButtonViewData?) -> some View {
        modifier(StackedButtons(primaryButton: primaryButton, secondaryButton: secondaryButton))
    }
}
