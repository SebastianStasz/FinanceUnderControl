//
//  SquareView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import SwiftUI
import SSUtils

public struct SquareView: View {
    @State private var imageSize: CGSize = .zero

    private let icon: String
    private let color: Color
    private let size: CGFloat?

    public init(icon: String, color: Color, size: CGFloat? = nil) {
        self.icon = icon
        self.color = color
        self.size = size
    }

    public var body: some View {
        SizeReader($imageSize) {
            Rectangle()
                .fill(color.opacity(0.2))
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .cornerRadius(squareSize * 0.24)
        }
        .overlay(image)
    }

    private var image: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(color)
            .padding(iconPadding)
    }

    private var iconPadding: CGFloat {
        squareSize * 0.3
    }

    private var squareSize: CGFloat {
        size ?? imageSize.height
    }
}

// MARK: - Preview

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SquareView(icon: "airplane", color: .red, size: 80)
            SquareView(icon: "house", color: .green, size: 80).darkScheme()
        }
        .sizeThatFits()
    }
}
