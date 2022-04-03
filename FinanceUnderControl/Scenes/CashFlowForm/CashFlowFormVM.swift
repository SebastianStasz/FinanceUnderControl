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
    typealias FormType = CashFlowFormType<CashFlowEntity>

    private let currencySettings = CurrencySettings()
    let didTapConfirm = PassthroughSubject<FormType, Never>()
//    var initialCashFlowModel: CashFlowFormModel!
    var nameInput = TextInputVM()
    var valueInput = DoubleInputVM()

    @Published var formModel = CashFlowEntity.FormModel()

    var formChanged: Bool {
//        initialCashFlowModel != cashFlowModel
        true
    }

    override init() {
        super.init()

        currencySettings.result().primaryCurrency
            .weakAssign(to: \.formModel.currency, on: self)

        CombineLatest(didTapConfirm, $formModel.compactMap { $0.model })
            .sink { [weak self] in self?.handleConfirmAction(for: $0.0) }
            .store(in: &cancellables)
    }

    func onAppear(formType: FormType) {
        formModel = formType.formModel
        nameInput = TextInputVM(initialValue: formModel.name, validator: .name())
        valueInput = DoubleInputVM(initialValue: formModel.value?.asString, validator: .money())
        nameInput.assignResult(to: \.formModel.name, on: self)
        valueInput.assignResult(to: \.formModel.value, on: self)
    }

    private func handleConfirmAction(for formType: FormType) {
        guard let model = formModel.model else { return }
        print(formType)
        switch formType {
        case .new:
            createCashFlow(model)
        case .edit:
            editCashFlow(form: formType, model: model)
        }
        baseAction.dismissView.send()
    }

    private func createCashFlow(_ model: CashFlowEntity.Model) {
        CashFlowEntity.createAndReturn(in: AppVM.shared.context, model: model)
        baseAction.dismissView.send()
    }

    private func editCashFlow(form: FormType, model: CashFlowEntity.Model) {
        guard let entity = form.entity else { return }
        _ = entity.edit(model: model)
    }
}
