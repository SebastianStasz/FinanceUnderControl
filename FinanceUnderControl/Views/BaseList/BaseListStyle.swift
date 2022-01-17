//
//  BaseListStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import SwiftUI

struct BaseListStyle: ViewModifier {

    let title: String
    let isEmpty: Bool
    let emptyMessage: String?
    let titleDisplayMode: NavigationBarItem.TitleDisplayMode

    func body(content: Content) -> some View {
        List { content }
            .emptyState(isEmpty: isEmpty, message: emptyMessage)
            .navigationBarTitleDisplayMode(titleDisplayMode)
            .navigationTitle(title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    func baseListStyle(title: String,
                       isEmpty: Bool,
                       emptyMessage: String? = nil,
                       titleDisplayMode: NavigationBarItem.TitleDisplayMode = .automatic
    ) -> some View {
        modifier(BaseListStyle(title: title,
                               isEmpty: isEmpty,
                               emptyMessage: emptyMessage,
                               titleDisplayMode: titleDisplayMode))
    }
}
