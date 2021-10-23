//
//  TabBarModel+Popup.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation
import Shared

extension TabBarModel {

    enum Popup {
        case first
        case second

        var title: String {
            switch self {
            case .first:
                return "Add income"
            case .second:
                return "Add expense"
            }
        }

        var icon: SFSymbol {
            switch self {
            case .first:
                return .plus
            case .second:
                return .minus
            }
        }
    }
}

// MARK: - Helpers

extension TabBarModel.Popup: CaseIterable {}
