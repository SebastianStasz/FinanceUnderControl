//
//  CircleViewDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import SwiftUI

public struct CircleViewDSView: View {

    public init() {}

    public var body: some View {
        Group {
            CircleView(color: .blue, size: 50)
                .designSystemComponent("Colored circle")

            CircleView(color: .blue, image: SFSymbol.close.rawValue, size: 50)
                .designSystemComponent("Circle with image")

            CircleView(color: .blue, image: SFSymbol.close.rawValue, size: 50)
                .selection(.constant("O"), element: "O")
                .designSystemComponent("Selected circle")
        }
        .designSystemView("Circle View")
    }
}

// MARK: - Preview

struct CircleViewDSView_Previews: PreviewProvider {
    static var previews: some View {
        CircleViewDSView()
        CircleViewDSView().darkScheme()
    }
}
