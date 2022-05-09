//
//  CashFlowCategoryFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import Foundation
import Shared
import SSValidation

final class CashFlowCategoryFormVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlowCategory>

    let formType: FormType
    let nameInput = TextInputVM()
    var formModel = CashFlowCategoryFormModel()

    init(for formType: FormType, coordinator: Coordinator) {
        self.formType = formType
        super.init(coordinator: coordinator)
    }
}
