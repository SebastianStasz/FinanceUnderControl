//
//  HorizontalBarView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 19/04/2022.
//

import SwiftUI

public struct HorizontalBarView: View {

    private let viewData: HorizontalBarVD

    public init(viewData: HorizontalBarVD) {
        self.viewData = viewData
    }

    public var body: some View {
        VStack(spacing: .xlarge) {
            ForEach(viewData.bars) { bar in
                VStack(spacing: .small) {
                    HStack(spacing: .medium) {
                        Text(bar.title, style: .footnote())
                            .padding(.leading, .micro)
                        Spacer()
                        Text("\((bar.value / viewData.total * 100).asString(roundToDecimalPlaces: 0))%", style: .footnote())
                    }

                    BarView(value: bar.value, total: viewData.total, color: bar.color)
                }
            }
        }
        .card()
    }
}

// MARK: - Preview

struct HorizontalBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalBarView(viewData: .sample)
            HorizontalBarView(viewData: .sample).darkScheme()
        }
        .sizeThatFits()
    }
}
