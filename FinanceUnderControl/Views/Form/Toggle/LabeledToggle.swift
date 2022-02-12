//
//  LabeledToggle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI
import Shared

struct LabeledToggle: View {

    @Binding private var isOn: Bool
    private let title: String

    init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }

    var body: some View {
        HStack(spacing: .big) {
            Text(title)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Toggle(title, isOn: $isOn)
                .labelsHidden()
        }
        .padding(.small)
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }
}


// MARK: - Preview

struct LabeledToggle_Previews: PreviewProvider {
    static var previews: some View {
        LabeledToggle("Labeled toggle", isOn: .constant(true))
            .asPreview()
    }
}
