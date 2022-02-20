//
//  HorizontalButtons.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/02/2022.
//

import SwiftUI

struct HorizontalButtons: View {

    private let primaryButton: BaseButton.Configuration
    private let secondaryButton: BaseButton.Configuration?
    private let shouldStandOut: Bool

    var body: some View {
        VStack {
            Divider().displayIf(shouldStandOut)

            HStack(spacing: .large) {
                if let secondaryButton = secondaryButton {
                    BaseButton(configuration: secondaryButton)
                }
                BaseButton(configuration: primaryButton)
            }
            .padding(.horizontal, .large)
            .padding(.top, .medium)
            .paddingIfNotSafeArea(.bottom, .medium)
            .background(shouldStandOut ?  Color.backgroundSecondary : Color.backgroundPrimary)
            .animation(.easeInOut(duration: 0.1))
        }
    }

    init(primaryButton: Configuration,
         secondaryButton: Configuration? = nil,
         shouldStandOut: Bool
    ) {
        self.primaryButton = .init(primaryButton.title, role: .primary, action: primaryButton.action)
        self.shouldStandOut = shouldStandOut
        if let sb = secondaryButton {
            self.secondaryButton = .init(sb.title, role: .secondary, action: sb.action)
        } else {
            self.secondaryButton = nil
        }
    }
}


// MARK: - Preview

struct HorizontalButtons_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalButtons(primaryButton: .init("Primary Button", action: {}),
                              shouldStandOut: true)

            HorizontalButtons(primaryButton: .init("Primary", action: {}),
                              secondaryButton: .init("Secondary", action: {}),
                              shouldStandOut: true)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
