//
//  CashFlowGroupingFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Combine
import CoreData
import SSValidation
import SSUtils
import FinanceCoreData

class CashFlowGroupingFormVM<Entity: CashFlowFormSupport>: ObservableObject, CombineHelper {
    typealias FormType = CashFlowFormType<Entity>

    var cancellables: Set<AnyCancellable> = []

    struct Input {
        let didTapConfirm = PassthroughSubject<FormType, Never>()
        let didTapDelete = PassthroughSubject<FormType, Never>()
    }

    let context: NSManagedObjectContext

    let input = Input()
    private(set) var nameInput = TextInputVM()
    @Published var formModel = Entity.FormModel()
    @Published private(set) var isFormValid = false

    init() {
        self.context = AppVM.shared.context

        nameInput.assignResult(to: \.formModel.name, on: self)

        $formModel
            .map { $0.model.notNil }
            .assign(to: &$isFormValid)

        input.didTapConfirm
            .combineLatest($formModel)
            .sink { [weak self] in self?.handleConfirmAction(form: $0.0) }
            .store(in: &cancellables)

        input.didTapDelete
            .sink { [weak self] in self?.deleteCashFlowGroup($0.entity) }
            .store(in: &cancellables)
    }

    func onAppear(formType: FormType) {
        self.formModel = formType.formModel
        let namesInUse = Entity.namesInUse(from: context, forType: formModel.type!).filter { $0 != formModel.name }
        nameInput = TextInputVM(initialValue: formModel.name, validator: .name(withoutRepeating: namesInUse))
        nameInput.assignResult(to: \.formModel.name, on: self)
    }

    private func handleConfirmAction(form: FormType) {
        guard let model = formModel.model else { return }
        switch form {
        case .new:
            createCashFlowCategoryGroup(model: model)
        case .edit:
            editCashFlowCategoryGroup(form: form, model: model)
        }
//        baseAction.dismissView.send()
    }

    private func createCashFlowCategoryGroup(model: Entity.Model) {
        Entity.create(in: context, model: model)
    }

    private func editCashFlowCategoryGroup(form: FormType, model: Entity.Model) {
        form.entity?.edit(model: model)
    }

    private func deleteCashFlowGroup(_ cashFlowGroup: Entity?) {
//        baseAction.dismissView.send()
        cashFlowGroup?.delete()
    }
}
