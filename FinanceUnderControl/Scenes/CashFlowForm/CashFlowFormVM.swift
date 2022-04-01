//
//  CashFlowFormVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import Combine
import Foundation
import SSValidation
import SSUtils
import FinanceCoreData

final class CashFlowFormVM: ViewModel {
    private let currencySettings = CurrencySettings()
    let didTapCreate = PassthroughSubject<Void, Never>()
    var initialCashFlowModel: CashFlowFormModel!
    let nameInput = TextInputVM(validator: .name())
    let valueInput = DoubleInputVM(validator: .money())

    @Published var cashFlowModel = CashFlowFormModel()

    var formChanged: Bool {
        initialCashFlowModel != cashFlowModel
    }

    override init() {
        super.init()

        currencySettings.result().primaryCurrency
            .weakAssign(to: \.cashFlowModel.currency, on: self)

        nameInput.assignResult(to: \.cashFlowModel.name, on: self)
        valueInput.assignResult(to: \.cashFlowModel.value, on: self)

        CombineLatest(didTapCreate, $cashFlowModel.compactMap { $0.model })
            .sink { [weak self] in self?.createCashFlow($0.1) }
            .store(in: &cancellables)
    }

    private func createCashFlow(_ model: CashFlowEntity.Model) {
        CashFlowEntity.create(in: AppVM.shared.context, model: model)
        baseAction.dismissView.send()
    }
}
