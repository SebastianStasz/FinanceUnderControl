//
//  BaseRowViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 29/11/2021.
//

import SwiftUI

struct BaseRowViewModifier: ViewModifier {

    let buttonType: BaseRowButtonType
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        Button(action: { action?() }) { content }
            .buttonStyle(BaseRowButtonStyle(buttonType: buttonType))
    }
}

extension View {
    func baseRowView(buttonType: BaseRowButtonType = .none, action: (() -> Void)? = nil) -> some View {
        self.modifier(BaseRowViewModifier(buttonType: buttonType, action: action))
    }
}


// MARK: - Preview

struct BaseRowViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("Some content").baseRowView(buttonType: .none)
            Text("Some content").baseRowView(buttonType: .add)
        }
        .previewLayout(.sizeThatFits)
    }
}
