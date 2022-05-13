//
//  CashFlowCategoryGroupFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import FinanceCoreData
import Foundation
import Shared
import SSValidation

final class CashFlowCategoryGroupFormVM: ViewModel {

    let type: CashFlowType
    let nameInput = TextInputVM()
    var formModel = CashFlowCategroupFormModel()

    init(for type: CashFlowType, coordinator: Coordinator) {
        self.type = type
        super.init(coordinator: coordinator)
    }
}
