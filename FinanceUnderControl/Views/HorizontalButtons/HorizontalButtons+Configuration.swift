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
        let action: Action

        init(_ title: String, action: @escaping Action) {
            self.title = title
            self.action = action
        }
    }
}
