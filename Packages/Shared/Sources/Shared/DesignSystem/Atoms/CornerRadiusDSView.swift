//
//  CornerRadiusDSView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

public struct CornerRadiusDSView: View {

    public init() {}

    public var body: some View {
        Group {
            ForEach(CornerRadius.allCases) {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 120, height: 60)
                    .cornerRadius($0.rawValue)
                    .designSystemComponent("\($0.name) - \(Int($0.rawValue).asString)")
            }
        }
        .designSystemView("Corner radius")
    }
}

// MARK: - Preview

struct CornerRadiusDSView_Previews: PreviewProvider {
    static var previews: some View {
        CornerRadiusDSView()
        CornerRadiusDSView().darkScheme()
    }
}
