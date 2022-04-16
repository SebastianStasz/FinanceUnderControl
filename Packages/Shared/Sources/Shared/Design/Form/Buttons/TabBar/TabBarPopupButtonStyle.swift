//
//  TabBarPopupButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public struct TabBarPopupButtonStyle: ButtonStyle {

    let image: String

    public init(image: String) {
        self.image = image
    }

    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.blue)

            Image(systemName: image)
                .foregroundColor(.white)
                .font(.system(size: 19, weight: .medium))
        }
        .shadow(color: .black.opacity(0.02), radius: 5)
    }
}
