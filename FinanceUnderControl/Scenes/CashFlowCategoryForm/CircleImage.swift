//
//  CircleImage.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import SwiftUI
import SSUtils
import FinanceCoreData

struct CircleView: View {
    @State private var imageSize: CGSize = .zero

    private let color: Color
    private let image: String?
    private let size: CGFloat?

    init(color: Color, image: String? = nil, size: CGFloat? = nil) {
        self.color = color
        self.image = image
        self.size = size
    }

    var body: some View {
        Circle()
            .fill(color)
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .overlay(imageView)
    }

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            SizeReader($imageSize) {
                Image(systemName: image)
                    .resizableToFit
                    .padding(imageSize.width * 0.26)
            }
        }
    }
}


extension CircleView {

    init(color: Color, icon: CashFlowCategoryIcon, size: CGFloat? = nil) {
        self.init(color: color, image: icon.rawValue, size: size)
    }
}


// MARK: - Preview

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleView(color: .red)
            CircleView(color: .blue, icon: .houseFill)
            CircleView(color: .teal, icon: .bagFill, size: 80)
        }
        .previewLayout(.sizeThatFits)
        .padding(.large)
    }
}
