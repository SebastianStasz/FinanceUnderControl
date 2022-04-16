//
//  SpacingDSView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

struct SpacingDSView: View {
    var body: some View {
        Group {
            ForEach(Spacing.allCases) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: $0.rawValue)
                    .designSystemComponent("\($0.name) - \(Int($0.rawValue).asString)")
            }
        }
        .designSystemView("Spacing")
    }
}

// MARK: - Preview

struct SpacingDSView_Previews: PreviewProvider {
    static var previews: some View {
        SpacingDSView()
        SpacingDSView().darkScheme()
    }
}
