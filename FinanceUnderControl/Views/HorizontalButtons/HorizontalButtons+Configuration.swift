//
//  HorizontalButtons+Configuration.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/02/2022.
//

import Foundation

extension HorizontalButtons {

    struct Configuration {
        let title: String
        let enabled: Bool
        let action: Action

        init(_ title: String, enabled: Bool = true, action: @escaping Action) {
            self.title = title
            self.enabled = enabled
            self.action = action
        }
    }
}
