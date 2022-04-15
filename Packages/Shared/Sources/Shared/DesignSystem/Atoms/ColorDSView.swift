//
//  ColorDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public struct ColorDSView: View {

    public init() {}

    public var body: some View {
        ForEach(ColorDesign.groups, content: colorList)
            .navigationTitle("Color")
    }

    private func colorList(for group: ColorDesign) -> some View {
        VStack(spacing: 10) {
            Text(group.title)
                .padding(.leading, 10)

            VStack(spacing: 10) {
                ForEach(group.colors, id: \.id) { color in
                    ZStack {
                        Rectangle()
                            .fill(color.color)
                            .frame(height: 50)
                        Text(color.rawValue)
                            .font(.caption)
                            .opacity(0.3)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

struct ColorsPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorDSView()
            ColorDSView().darkScheme()
        }
    }
}
