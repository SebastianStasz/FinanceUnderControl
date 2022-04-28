//
//  RegisterPasswordHintView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Shared
import SwiftUI

struct RegisterPasswordHintView: View {

    let viewData: RegisterPasswordHintVD

    var body: some View {
        VStack(spacing: .micro) {
            Text("Minimum of 8 characters", style: styleFor(isValid: viewData.isEightCharactersLong))
            Text("Contains special characters", style: styleFor(isValid: viewData.isSpecialCharacter))
            Text("Contains numbers", style: styleFor(isValid: viewData.isNumber))
            Text("Contains upper and lower case letters", style: styleFor(isValid: viewData.isUpperAndLowerCharacter))
        }
    }

    private func styleFor(isValid: Bool) -> TextStyle {
        .footnote(isValid ? .valid : .invalid)
    }
}

// MARK: - Preview

struct RegisterPasswordHintView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegisterPasswordHintView(viewData: .init(for: "Se.12.se"))
            RegisterPasswordHintView(viewData: .init(for: "Se.12.se")).darkScheme()
        }
        .sizeThatFits()
    }
}
