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
//            Sector("Atoms") {
//                Navigation("Text", leadsTo: TextDSView.init)eViewDSView.init)
//                Navigation("Color", leadsTo: ColorDSView.init)
//                Navigation("SF symbol", leadsTo: SFSymbolDSView.init)
//                Navigation("Spacing", leadsTo: SpacingDSView.init)
//                Navigation("Corner radius", leadsTo: CornerRadiusDSView.init)
//            }
//
//            Sector("Form") {
//                Navigation("Button", leadsTo: ButtonDSView.init)
//                Navigation("Toggle", leadsTo: ToggleDSView.init)
//                Navigation("Picker", leadsTo: PickerDSView.init)
//                Navigation("Text Field", leadsTo: TextFieldDSView.init)
//            }
//
//            Sector("Other") {
//                Navigation("Sector", leadsTo: SectorDSView.init)
//                Navigation("Description", leadsTo: DescriptionDSView.init)
//                Navigation("Circle view", leadsTo: Circl
//            }
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
