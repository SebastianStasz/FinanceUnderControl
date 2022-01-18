//
//  CashFlowPopupVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 12/01/2022.
//

import Combine
import CoreData
import Foundation
import SSValidation

final class CashFlowPopupVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []

    @Published var nameInput = Input<TextInputSettings>(settings: .init(minLength: 3, maxLength: 20))
    @Published var valueInput = Input<NumberInputSettings>(settings: .init(minValue: 0.01, keyboardType: .numbersAndPunctuation))
    @Published var cashFlowModel = CashFlowModel()
    private let currencySettings = CurrencySettings()

    init() {
        let currencySettingsOutput = currencySettings.bind()
        currencySettingsOutput.primaryCurrency
            .sink { [weak self] currency in
                self?.cashFlowModel.currency = currency
            }
            .store(in: &cancellables)

        $valueInput.map { $0.value }
            .sink { [weak self] cashFlowValue in
                self?.cashFlowModel.value = cashFlowValue
            }
            .store(in: &cancellables)

        $nameInput.map { $0.value }
        .sink { [weak self] cashFlowName in
            self?.cashFlowModel.name = cashFlowName
        }
        .store(in: &cancellables)
    }
}
