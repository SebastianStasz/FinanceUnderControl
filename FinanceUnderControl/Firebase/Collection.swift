//
//  Collection.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Foundation
import Shared

enum Collection: String {
    case users
    case wallets
    case cashFlows
    case cashFlowCategories
    case cashFlowCategoryGroups

    var name: String {
        rawValue
    }

    var documentIdPrefix: String {
        switch self {
        case .users:
            return "user_"
        case .wallets:
            return "wallet_"
        case .cashFlows:
            return "cashFlow_"
        case .cashFlowCategories:
            return "cashFlowCategory_"
        case .cashFlowCategoryGroups:
            return "cashFlowCategoryGroup_"
        }
    }
}
