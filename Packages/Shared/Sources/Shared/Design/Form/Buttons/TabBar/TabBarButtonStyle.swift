//
//  TabBarButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SSUtils
import SwiftUI

public struct TabBarButtonStyle: ButtonStyle {
    var image: Image
    var isSelected: Bool

    public init(image: Image, isSelected: Bool) {
        self.image = image
        self.isSelected = isSelected
    }

    public func makeBody(configuration: Configuration) -> some View {
        image
            .scaledToFit(height: 18)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(isSelected ? .blue : .grayMedium)
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeInOut, value: 0.1)
            .contentShape(Circle())
    }
}
