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

final class CashFlowCategoryGroupFromVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlowCategoryGroupEntity>
    
    struct Input {
        let didTapConfirm = PassthroughSubject<FormType, Never>()
    }
    
    private let context: NSManagedObjectContext
    
    let input = Input()
    @Published var categoryModel = CashFlowCategoryGroupModel()
    @Published private(set) var isFormValid = false
    
    override init() {
        self.context = AppVM.shared.context
        super.init()
        
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
        baseAction.dismissView.send()
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
