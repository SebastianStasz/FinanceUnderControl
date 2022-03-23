//
//  CashFlowCategoryFormVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Combine
import CoreData
import Foundation
import FinanceCoreData
import SSValidation
import SSUtils

final class CashFlowCategoryFormVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlowCategoryEntity>

    struct Input {
        let didTapConfirm = PassthroughSubject<FormType, Never>()
    }

    private let context: NSManagedObjectContext

    let input = Input()
    private(set) var nameInput = TextInputVM()
    @Published var categoryModel = CashFlowCategoryModel()
    @Published private(set) var isFormValid = false

    override init() {
        self.context = AppVM.shared.context
        super.init()

        nameInput.assignResult(to: \.categoryModel.name, on: self)

        $categoryModel
            .map { $0.data.notNil }
            .assign(to: &$isFormValid)

        input.didTapConfirm
            .combineLatest($categoryModel)
            .sink { [weak self] in self?.handleConfirmAction(form: $0.0, model: $0.1) }
            .store(in: &cancellables)
    }

    func onAppear(withModel model: CashFlowCategoryEntity.Model) {
        categoryModel = model
        let namesInUse = CashFlowCategoryEntity.getAll(from: context).compactMap { $0.name == model.name ? nil : $0.name}
        nameInput = TextInputVM(initialValue: model.name, validator: .name(withoutRepeating: namesInUse))
    }

    private func handleConfirmAction(form: FormType, model: CashFlowCategoryModel?) {
        guard let data = model?.data else { return }
        switch form {
        case .new:
            createCashFlowCategory(data: data)
        case .edit:
            editCashFlowCategory(form: form, data: data)
        }
        baseAction.dismissView.send()
    }

    private func createCashFlowCategory(data: CashFlowCategoryData) {
        CashFlowCategoryEntity.create(in: context, data: data)
    }

    private func editCashFlowCategory(form: FormType, data: CashFlowCategoryData) {
        form.entity?.edit(data: data)
    }
}
