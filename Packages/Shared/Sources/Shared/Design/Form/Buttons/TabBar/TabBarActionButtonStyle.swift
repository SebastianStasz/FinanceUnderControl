//
//  TabBarActionButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public struct TabBarActionButtonStyle: ButtonStyle {

    public init() {}

    static private let linearGradient = Gradient(colors: [.basicPrimary, .basicPrimary, .blue])
    static private let actionBtnGradient = LinearGradient(gradient: Self.linearGradient, startPoint: .top, endPoint: .bottom)

    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.blue)

            SFSymbol.plus.image
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
        }
    }
}
