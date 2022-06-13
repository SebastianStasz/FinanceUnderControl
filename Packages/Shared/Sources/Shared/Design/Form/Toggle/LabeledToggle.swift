//
//  LabeledToggle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI

public struct LabeledToggle: View {

    @Binding private var isOn: Bool
    private let title: String

    public init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }

    public var body: some View {
        HStack(spacing: .xlarge) {
            Text(title)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Toggle(title, isOn: $isOn)
                .labelsHidden()
        }
        .frame(height: 48)
        .padding(.horizontal, .medium)
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }
}

// MARK: - Preview

struct LabeledToggle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabeledToggle("Labeled toggle", isOn: .constant(true))
            LabeledToggle("Labeled toggle", isOn: .constant(true)).darkScheme()
        }
        .sizeThatFits()
    }
}
