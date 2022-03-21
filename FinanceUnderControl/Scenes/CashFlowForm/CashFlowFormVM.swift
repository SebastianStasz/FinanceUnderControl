//
//  CashFlowFormVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import Combine
import Foundation
import SSValidation

final class CashFlowFormVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []

    let nameInput = TextInputVM(validator: .notEmpty().and(.lengthBetween(3...20)))
    let valueInput = DoubleInputVM(validator: .notEmpty().andDouble(.notLessThan(0.01)))
    @Published var cashFlowModel = CashFlowModel()
    private let currencySettings = CurrencySettings()

    init() {
        let currencySettingsOutput = currencySettings.bind()
        currencySettingsOutput.primaryCurrency
            .sink { [weak self] currency in
                self?.cashFlowModel.currency = currency
            }
            .store(in: &cancellables)

        nameInput.result().sink { [weak self] in
            self?.cashFlowModel.name = $0
        }
        .store(in: &cancellables)

        valueInput.result().sink { [weak self] in
            self?.cashFlowModel.value = $0
        }
        .store(in: &cancellables)
    }
}
