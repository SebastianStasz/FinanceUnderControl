//
//  CashFlowFormVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import Combine
import Foundation
import SSUtils
import SSValidation

final class CashFlowFormVM: ObservableObject, CombineHelper {
    var cancellables: Set<AnyCancellable> = []

    let nameInput = TextInputVM(validator: .notEmpty().and(.lengthBetween(3...20)))
    let valueInput = DoubleInputVM(validator: .notEmpty().andDouble(.notLessThan(0.01)))
    @Published var cashFlowModel = CashFlowModel()
    private let currencySettings = CurrencySettings()

    init() {
        currencySettings.bind().primaryCurrency
            .weakAssign(to: \.cashFlowModel.currency, on: self)

        nameInput.assignResult(to: \.cashFlowModel.name, on: self)
        valueInput.assignResult(to: \.cashFlowModel.value, on: self)
    }
}
