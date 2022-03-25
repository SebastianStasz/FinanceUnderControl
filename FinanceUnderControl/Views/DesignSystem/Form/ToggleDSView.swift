//
//  ToggleDSView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

struct ToggleDSView: View {

    @State private var toggle1 = false

    var body: some View {
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
        ToggleDSView().embedInNavigationView()
    }
}
