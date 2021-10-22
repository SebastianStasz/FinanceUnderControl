//
//  TabBarButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SSUtils
import SwiftUI

struct TabBarButtonStyle: ButtonStyle {
    var image: Image
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        image
            .scaledToFit(height: 18)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(isSelected ? .red : .grayMedium)
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeInOut, value: 0.1)
            .contentShape(Circle())
    }
}

// MARK: - Initializers

extension TabBarButtonStyle {
    init(for tab: TabBarModel, isSelected: Bool) {
        self.init(image: tab.icon.image, isSelected: isSelected)
    }
}
