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
        let enabled: Bool
        let action: Action

        init(_ title: String, role: Role, enabled: Bool = true, action: @escaping Action) {
            self.title = title
            self.role = role
            self.enabled = enabled
            self.action = action
        }

        init(_ title: String, role: Role, enabled: Bool = true, action: @autoclosure @escaping Action) {
            self.init(title, role: role, enabled: enabled, action: action)
        }
    }
}
