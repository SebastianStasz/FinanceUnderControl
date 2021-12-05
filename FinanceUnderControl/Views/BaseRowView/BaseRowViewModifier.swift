//
//  BaseRowViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 29/11/2021.
//

import SwiftUI

struct BaseRowViewModifier: ViewModifier {

    let buttonType: BaseRowButtonType
    let isBlue: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        Button(action: { action() }) { content }
            .buttonStyle(BaseRowButtonStyle(buttonType: buttonType, isBlue: isBlue))
    }
}

extension View {
    func baseRowView(buttonType: BaseRowButtonType = .none,
                     isBlue: Bool = false,
                     action: @autoclosure @escaping () -> Void
    ) -> some View {
        self.modifier(BaseRowViewModifier(buttonType: buttonType, isBlue: isBlue, action: action))
    }
}


// MARK: - Preview

struct BaseRowViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("Some content").baseRowView(buttonType: .none, action: ())
            Text("Some content").baseRowView(buttonType: .add, action: ())
        }
        .previewLayout(.sizeThatFits)
    }
}
