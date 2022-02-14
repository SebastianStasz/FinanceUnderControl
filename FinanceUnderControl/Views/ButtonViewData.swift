//
//  ButtonViewData.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 14/02/2022.
//

import Foundation

struct ButtonViewData {
    let title: String
    let action: () -> Void

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
