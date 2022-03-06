//
//  SectorDSView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import SwiftUI

struct SectorDSView: View {
    var body: some View {
        FormView {
            Sector("Clear style", style: .clear) { text }
            Sector("Card style", style: .card) { text }
        }
    }

    private var text: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec feugiat laoreet nisl, a cursus lacus vehicula vitae. Nam tempus placerat leo, malesuada dapibus libero convallis a.")
    }
}


// MARK: - Preview

struct SectorDSView_Previews: PreviewProvider {
    static var previews: some View {
        SectorDSView()
    }
}
