//
//  CashFlowCategoryGroupFromVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Combine
import CoreData
import FinanceCoreData
import Foundation
import SSUtils
import SSValidation

final class CashFlowCategoryGroupFromVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlowCategoryGroupEntity>

    struct Input {
        let didTapConfirm = PassthroughSubject<FormType, Never>()
    }

    private let context: NSManagedObjectContext

    let input = Input()
    private(set) var nameInput = TextInputVM()
    @Published var categoryModel = CashFlowCategoryGroupModel()
    @Published private(set) var isFormValid = false

    override init() {
        self.context = AppVM.shared.context
        super.init()

        nameInput.result().sink { [weak self] in
            self?.categoryModel.name = $0
        }
        .store(in: &cancellables)

        $categoryModel
            .map { $0.data.notNil }
            .assign(to: &$isFormValid)

        input.didTapConfirm
            .combineLatest($categoryModel)
            .sink { [weak self] in self?.handleConfirmAction(form: $0.0, model: $0.1) }
            .store(in: &cancellables)
    }

    func onAppear(withModel model: CashFlowCategoryGroupEntity.Model) {
        self.categoryModel = model
        let namesInUse = CashFlowCategoryGroupEntity.getAll(from: context).compactMap { $0.name == model.name ? nil : $0.name }
        nameInput = TextInputVM(initialValue: model.name, validator: .name(withoutRepeating: namesInUse))
    }

    private func handleConfirmAction(form: FormType, model: CashFlowCategoryGroupModel?) {
        guard let data = model?.data else { return }
        switch form {
        case .new:
            createCashFlowCategoryGroup(data: data)
        case .edit:
            editCashFlowCategoryGroup(form: form, data: data)
        }
        baseAction.dismissView.send()
    }

    private func createCashFlowCategoryGroup(data: CashFlowCategoryGroupData) {
        CashFlowCategoryGroupEntity.create(in: context, data: data)
    }

    private func editCashFlowCategoryGroup(form: FormType, data: CashFlowCategoryGroupData) {
        form.entity?.edit(data: data)
    }
}
