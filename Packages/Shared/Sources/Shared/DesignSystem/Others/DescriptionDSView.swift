//
//  DescriptionDSView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

struct DescriptionDSView: View {
    var body: some View {
        Group {
            Description("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec feugiat laoreet nisl, a cursus lacus vehicula vitae. Nam tempus placerat leo, malesuada dapibus libero convallis.")
        }
        .designSystemView("Description")
    }
}

struct DescriptionDSView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionDSView()
        DescriptionDSView().darkScheme()
    }
}
