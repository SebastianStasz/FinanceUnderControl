//
//  CircleImage.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import SwiftUI
import SSUtils

public struct CircleView: View {
    @State private var imageSize: CGSize = .zero

    private let color: Color
    private let image: String?
    private let size: CGFloat?

    public init(color: Color, image: String? = nil, size: CGFloat? = nil) {
        self.color = color
        self.image = image
        self.size = size
    }

    public var body: some View {
        SizeReader($imageSize) {
            Circle()
                .fill(color)
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        }
        .overlay(imageView)
    }

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            Image(systemName: image)
                .resizableToFit
                .padding(demandSize)
        }
    }

    private var demandSize: CGFloat {
        if let size = size {
            return size * 0.26
        }
        return imageSize.height * 0.26
    }
}

// MARK: - Preview

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleView(color: .red)
            CircleView(color: .blue, image: SFSymbol.close.rawValue)
            CircleView(color: .teal, image: SFSymbol.filter.rawValue, size: 80)
        }
        .previewLayout(.sizeThatFits)
        .padding(.large)
    }
}
