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

final class CashFlowCategoryGroupFromVM: ObservableObject {
    typealias FormType = CashFlowFormType<CashFlowCategoryGroupEntity>
    
    private struct Action {
        let dismissView = PassthroughSubject<Void, Never>()
    }

    struct Output {
        let dismissView: Driver<Void>
    }
    
    struct Input {
        let didTapConfirm = PassthroughSubject<FormType, Never>()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private let context: NSManagedObjectContext
    private let action = Action()
    
    let output: Output
    let input = Input()
    @Published var categoryModel = CashFlowCategoryGroupModel()
    @Published private(set) var isFormValid = false
    
    init() {
        self.context = AppVM.shared.context
        output = .init(dismissView: action.dismissView.asDriver)
        
        $categoryModel
            .map { $0.nameInput.value != nil }
            .assign(to: &$isFormValid)
        
        input.didTapConfirm
            .combineLatest($categoryModel)
            .sink { [weak self] in self?.handleConfirmAction(form: $0.0, model: $0.1) }
            .store(in: &cancellables)
    }
    
    private func handleConfirmAction(form: FormType, model: CashFlowCategoryGroupModel?) {
        guard let data = model?.data else { return }
        switch form {
        case .new:
            createCashFlowCategoryGroup(data: data)
        case .edit:
            editCashFlowCategoryGroup(form: form, data: data)
        }
        action.dismissView.send()
    }
    
    private func createCashFlowCategoryGroup(data: CashFlowCategoryGroupData) {
        CashFlowCategoryGroupEntity.create(in: context, data: data)
    }

    private func editCashFlowCategoryGroup(form: FormType, data: CashFlowCategoryGroupData) {
        form.entity?.edit(data: data)
    }

    private func updateBlockedCategoryNames() {
        let categories = CashFlowCategoryGroupEntity.getAll(from: context)
        categoryModel.nameInput.settings.blocked.values = categories.map { $0.name }
    }
}
