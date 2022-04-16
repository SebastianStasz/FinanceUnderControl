//
//  TabBarActionButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public struct TabBarActionButtonStyle: ButtonStyle {

    let isEnabled: Bool

    public init(isEnabled: Bool) {
        self.isEnabled = isEnabled
    }

    static private let linearGradient = Gradient(colors: [.basicPrimary, .basicPrimary, .blue])
    static private let actionBtnGradient = LinearGradient(gradient: Self.linearGradient, startPoint: .top, endPoint: .bottom)

    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Self.actionBtnGradient)
                .scaleEffect(1.2)

            Circle()
                .foregroundColor(.blue)

            SFSymbol.plus.image
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .medium))
                .rotationEffect(isEnabled ? Angle(degrees: 45) : .zero)
        }
        .animation(.easeInOut(duration: 0.2))
    }
}
