//
//  CashFlowFormVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import Foundation
import SSValidation

final class CashFlowFormVM: ViewModel {
    private let currencySettings = CurrencySettings()
    var initialCashFlowModel: CashFlowBuild!
    let nameInput = TextInputVM(validator: .name())
    let valueInput = DoubleInputVM(validator: .money())

    @Published var cashFlowModel = CashFlowBuild()

    var formChanged: Bool {
        initialCashFlowModel != cashFlowModel
    }

    override init() {
        super.init()

        currencySettings.result().primaryCurrency
            .weakAssign(to: \.cashFlowModel.currency, on: self)

        nameInput.assignResult(to: \.cashFlowModel.name, on: self)
        valueInput.assignResult(to: \.cashFlowModel.value, on: self)
    }
}
