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
import SwiftUI

//final class CashFlowFormVM2<Entity: CashFlowFormSupport>: ViewModel {
//    typealias FormType = CashFlowFormType<Entity>
//
//    struct Input {
//        let didTapConfirm = PassthroughSubject<FormType, Never>()
//    }
//
//    private let context: NSManagedObjectContext
//
//    let input = Input()
//    private(set) var nameInput = TextInputVM()
//    @Published var categoryModel = Entity.Model()
//    @Published private(set) var isFormValid = false
//
//    override init() {
//        self.context = AppVM.shared.context
//        super.init()
//
//        nameInput.assignResult(to: \.categoryModel.name, on: self)
//
//        $categoryModel
//            .map { $0.data.notNil }
//            .assign(to: &$isFormValid)
//    }
//}

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

        $categoryModel
            .map { $0.data.notNil }
            .assign(to: &$isFormValid)

        input.didTapConfirm
            .combineLatest($categoryModel)
            .sink { [weak self] in self?.handleConfirmAction(form: $0.0, model: $0.1) }
            .store(in: &cancellables)
    }

    func onAppear(withModel model: CashFlowCategoryGroupEntity.FormModel) {
        self.categoryModel = model
        let namesInUse = CashFlowCategoryGroupEntity.getAll(from: context).compactMap { $0.name == model.name ? nil : $0.name }
        nameInput = TextInputVM(initialValue: model.name, validator: .name(withoutRepeating: namesInUse))
        nameInput.assignResult(to: \.categoryModel.name, on: self)
    }

    private func handleConfirmAction(form: FormType, model: CashFlowCategoryGroupModel?) {
        guard let model = model?.data else { return }
        switch form {
        case .new:
            createCashFlowCategoryGroup(model: model)
        case .edit:
            editCashFlowCategoryGroup(form: form, model: model)
        }
        baseAction.dismissView.send()
    }

    private func createCashFlowCategoryGroup(model: CashFlowCategoryGroupEntity.Model) {
        CashFlowCategoryGroupEntity.create(in: context, model: model)
    }

    private func editCashFlowCategoryGroup(form: FormType, model: CashFlowCategoryGroupEntity.Model) {
        form.entity?.edit(model: model)
    }
}
