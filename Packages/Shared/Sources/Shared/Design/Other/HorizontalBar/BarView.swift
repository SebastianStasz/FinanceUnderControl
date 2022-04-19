//
//  BarView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 19/04/2022.
//

import SwiftUI
import SSUtils

struct BarView: View {
    @State private var barSize: CGSize = .zero

    let value: Double
    let total: Double
    let color: Color

    var percentage: Double {
        guard total != 0 else { return 1 }
        return value / total
    }

    var body: some View {
        SizeReader($barSize) {
            Rectangle()
                .fill(Color.backgroundPrimary)
                .frame(height: 6)
                .overlay(indicator, alignment: .leading)
                .cornerRadius(.base)
        }
    }

    private var indicator: some View {
        color.frame(width: barSize.width * percentage)
            .cornerRadius(.base)
    }
}

// MARK: - Preview

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarView(value: 45, total: 100, color: .cyan)
            BarView(value: 25, total: 100, color: .cyan).darkScheme()
        }
        .sizeThatFits()
    }
}
