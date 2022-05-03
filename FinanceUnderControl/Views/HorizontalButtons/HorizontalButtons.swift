//
//  HorizontalButtons.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/02/2022.
//

import Shared
import SwiftUI

struct HorizontalButtons: View {

    private let primaryButton: BaseButton.Configuration
    private let secondaryButton: BaseButton.Configuration?

    var body: some View {
        HStack(spacing: .large) {
            if let secondaryButton = secondaryButton {
                BaseButton(configuration: secondaryButton)
            }
            BaseButton(configuration: primaryButton)
        }
        .padding(.top, .medium)
    }

    init(primaryButton: Configuration, secondaryButton: Configuration? = nil) {
        self.primaryButton = .init(primaryButton.title,
                                   role: .primary,
                                   enabled: primaryButton.enabled,
                                   action: primaryButton.action
        )
        if let sb = secondaryButton {
            self.secondaryButton = .init(sb.title, role: .secondary, enabled: sb.enabled, action: sb.action)
        } else {
            self.secondaryButton = nil
        }
    }

    init?(primaryButton: Configuration?, secondaryButton: Configuration? = nil) {
        guard let primaryButton = primaryButton else { return nil }
        self.init(primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
}

extension View {
    func horizontalButtons(primaryButton: HorizontalButtons.Configuration, secondaryButton: HorizontalButtons.Configuration? = nil) -> some View {
        self.toolbar {
            ToolbarItem.init(placement: .bottomBar) {
                HorizontalButtons(primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
        }
    }
}

// MARK: - Preview

struct HorizontalButtons_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalButtons(primaryButton: .init("Primary Button", action: {}))

            HorizontalButtons(primaryButton: .init("Primary", action: {}),
                              secondaryButton: .init("Secondary", action: {}))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
