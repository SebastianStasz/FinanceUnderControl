//
//  DesignSystemView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SSUtils
import SwiftUI

public struct DesignSystemView: View {

    public init() {}

    public var body: some View {
        FormView {
            Sector("Atoms") {
                Navigation("Texts", leadsTo: TextDSView.init)
                Navigation("Colors", leadsTo: ColorDSView.init)
            }

            Sector("Form") {
                Navigation("Buttons", leadsTo: ButtonDSView.init)
                Navigation("Toggles", leadsTo: ToggleDSView.init)
//                Navigation("Pickers", leadsTo: PickerDSView.init)
                Navigation("Text Fields", leadsTo: TextFieldDSView.init)
            }

            Sector("Other") {
                Navigation("Sector", leadsTo: SectorDSView.init)
                Navigation("Circle View", leadsTo: CircleViewDSView.init)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

struct DesignSystemView_Previews: PreviewProvider {
    static var previews: some View {
        DesignSystemView()
        DesignSystemView().darkScheme()
    }
}
