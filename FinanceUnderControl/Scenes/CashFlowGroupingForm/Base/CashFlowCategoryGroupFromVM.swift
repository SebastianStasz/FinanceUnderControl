//
//  CashFlowGroupingFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Combine
import CoreData
import SSValidation

final class CashFlowGroupingFormVM<Entity: CashFlowFormSupport>: ViewModel {
    typealias FormType = CashFlowFormType<Entity>

    struct Input {
        let didTapConfirm = PassthroughSubject<FormType, Never>()
    }

    private let context: NSManagedObjectContext

    let input = Input()
    private(set) var nameInput = TextInputVM()
    @Published var build = Entity.Build()
    @Published private(set) var isFormValid = false

    override init() {
        self.context = AppVM.shared.context
        super.init()

        nameInput.assignResult(to: \.build.name, on: self)

        $build
            .map { $0.model.notNil }
            .assign(to: &$isFormValid)

        input.didTapConfirm
            .combineLatest($build)
            .sink { [weak self] in self?.handleConfirmAction(form: $0.0, formModel: $0.1) }
            .store(in: &cancellables)
    }

    func onAppear(withModel model: Entity.Build) {
        self.build = model
        let namesInUse = Entity.namesInUse(from: context).filter { $0 != model.name }
        nameInput = TextInputVM(initialValue: model.name, validator: .name(withoutRepeating: namesInUse))
        nameInput.assignResult(to: \.build.name, on: self)
    }

    private func handleConfirmAction(form: FormType, formModel: Entity.Build) {
        guard let model = formModel.model else { return }
        switch form {
        case .new:
            createCashFlowCategoryGroup(model: model)
        case .edit:
            editCashFlowCategoryGroup(form: form, model: model)
        }
        baseAction.dismissView.send()
    }

    private func createCashFlowCategoryGroup(model: Entity.Model) {
        Entity.create(in: context, model: model)
    }

    private func editCashFlowCategoryGroup(form: FormType, model: Entity.Model) {
        form.entity?.edit(model: model)
    }
}
