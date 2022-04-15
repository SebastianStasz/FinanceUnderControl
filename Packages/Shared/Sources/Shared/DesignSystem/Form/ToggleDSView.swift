//
//  ToggleDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

public struct ToggleDSView: View {

    public init() {}

    @State private var toggle1 = false

    public var body: some View {
        Group {
            LabeledToggle("Toggle title", isOn: $toggle1)
                .designSystemComponent("Labeled Toggle")
        }
        .designSystemView("Toggle")
    }
}

// MARK: - Preview

struct ToggleDSView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToggleDSView()
            ToggleDSView().darkScheme()
        }
    }
}
