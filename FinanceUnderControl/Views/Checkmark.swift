//
//  Checkmark.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 26/02/2022.
//

import SwiftUI
import Shared

struct Checkmark: View {
    let isChecked: Bool

    var body: some View {
        if isChecked {
            SFSymbol.checkmarkChecked.image
                .foregroundColor(.green)
        } else {
            SFSymbol.checkmarkUnchecked.image
                .opacity(0.5)
        }
    }
}


// MARK: - Preview

struct Checkmark_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Checkmark(isChecked: true)
            Checkmark(isChecked: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
