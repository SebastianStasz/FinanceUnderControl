//
//  Radio.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 26/02/2022.
//

import SwiftUI
import Shared

struct Radio: View {
    let isSelected: Bool

    var body: some View {
        if isSelected {
            SFSymbol.radioChecked.image
                .foregroundColor(.green)
        } else {
            SFSymbol.radioUnchecked.image
                .opacity(0.5)
        }
    }
}


// MARK: - Preview

struct Checkmark_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Radio(isSelected: true)
            Radio(isSelected: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
