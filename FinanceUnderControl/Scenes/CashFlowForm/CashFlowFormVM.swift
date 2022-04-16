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
    var initialFormModel: CashFlowEntity.FormModel!
    var nameInput = TextInputVM()
    var valueInput = DecimalInputVM()

    @Published var formModel = CashFlowEntity.FormModel()

    var formChanged: Bool {
        initialFormModel != formModel
    }

    override init() {
        super.init()

//        currencySettings.result().primaryCurrency
//            .filter { [unowned self] _ in self.formModel.currency.isNil }
//            .sink { [unowned self] in
//                self.initialFormModel.currency = $0
//                self.formModel.currency = $0
//            }
//            .store(in: &cancellables)

        CombineLatest(didTapConfirm, $formModel.compactMap { $0.model })
            .sink { [weak self] in self?.handleConfirmAction(for: $0.0) }
            .store(in: &cancellables)
    }

    func onAppear(formType: FormType) {
        formModel = formType.formModel
        formModel.currency = CurrencyEntity.get(withCode: "PLN", from: AppVM.shared.context)!
        initialFormModel = formModel
        nameInput = TextInputVM(initialValue: formModel.name, validator: .name())
        valueInput = DecimalInputVM(initialValue: "formModel.value?.asString", validator: .money())
        nameInput.assignResult(to: \.formModel.name, on: self)
        valueInput.assignResult(to: \.formModel.value, on: self)
    }

    private func handleConfirmAction(for formType: FormType) {
        guard let model = formModel.model else { return }
        switch formType {
        case .new:
            createCashFlow(model)
        case .edit:
            editCashFlow(form: formType, model: model)
        }
        try? AppVM.shared.context.save()
        AppVM.shared.events.cashFlowsChanged.send()
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
