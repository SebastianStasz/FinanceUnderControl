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
                .cornerRadius(.base)
        }
        .overlay(image)
    }

    private var image: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(color)
            .padding(demandSize)
    }

    private var demandSize: CGFloat {
        if let size = size {
            return size * 0.3
        }
        return imageSize.height * 0.3
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
