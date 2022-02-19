//
//  BaseButton+Configuration.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/02/2022.
//

import Foundation

extension BaseButton {

    struct Configuration {
        let title: String
        let role: Role
        let action: Action

        init(_ title: String, role: Role, action: @escaping Action) {
            self.title = title
            self.role = role
            self.action = action
        }

        init(_ title: String, role: Role, action: @autoclosure @escaping Action) {
            self.init(title, role: role, action: action)
        }
    }
}
