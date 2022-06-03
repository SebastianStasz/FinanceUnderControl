//
//  SectorDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import SwiftUI

public struct SectorDSView: View {

    public init() {}

    public var body: some View {
        FormView {
            Sector("Clear style", style: .clear) { text }
            Sector("Card style", style: .card) { text }
        }
        .navigationTitle("Sector")
    }

    private var text: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec feugiat laoreet nisl, a cursus lacus vehicula vitae. Nam tempus placerat leo, malesuada dapibus libero convallis.")
    }
}

// MARK: - Preview

struct SectorDSView_Previews: PreviewProvider {
    static var previews: some View {
        SectorDSView()
        SectorDSView().darkScheme()
    }
}
