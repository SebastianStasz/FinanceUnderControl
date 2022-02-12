//
//  BaseButton.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/01/2022.
//

import SwiftUI
import SSUtils

struct BaseButton: View {

    private let title: String
    private let role: ButtonRole
    private let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(BaseButtonStyle(role: role))
    }

    init(_ title: String, role: ButtonRole = .action, action: @escaping () -> Void) {
        self.title = title
        self.role = role
        self.action = action
    }

    init(_ title: String, role: ButtonRole = .action, action: @autoclosure @escaping () -> Void) {
        self.init(title, role: role, action: action)
    }
}
