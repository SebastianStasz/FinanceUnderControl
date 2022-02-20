//
//  PopupModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 11/01/2022.
//

import FinanceCoreData
import SwiftUI

enum PopupModel {
    case cashFlowCategory(for: CashFlowCategoryType)
}

extension PopupModel: View {
    var body: some View {
        Group {
            switch self {
            case let .cashFlowCategory(type):
                CashFlowCategoryPopup(for: type)
            }
        }
    }
}
