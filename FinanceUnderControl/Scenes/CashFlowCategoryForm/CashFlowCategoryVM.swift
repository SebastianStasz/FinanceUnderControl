//
//  CashFlowCategoryVM.swift
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

final class CashFlowCategoryVM: ObservableObject {

    private struct Action {
        let dismissView = PassthroughSubject<Void, Never>()
    }

    struct Output {
        let dismissView: Driver<Void>
    }

    struct Input {
        let didTapCreate = PassthroughSubject<Void, Never>()
    }
    private var cancellables: Set<AnyCancellable> = []
    private let context: NSManagedObjectContext
    private let action = Action()

    let output: Output
    let input = Input()
    @Published var categoryModel = CashFlowCategoryModel()
    @Published private(set) var isFormValid = false

    init() {
        self.context = AppVM.shared.context
        output = .init(dismissView: action.dismissView.asDriver)
        updateBlockedCategoryNames()

        $categoryModel
            .map { $0.nameInput.value != nil }
            .assign(to: &$isFormValid)

        input.didTapCreate
            .combineLatest($categoryModel)
            .sink { [weak self] in self?.createCategory(model: $0.1) }
            .store(in: &cancellables)
    }

    private func createCategory(model: CashFlowCategoryModel?) {
        guard let data = model?.data else { return }
        CashFlowCategoryEntity.create(in: context, data: data)
        action.dismissView.send()
    }

    private func updateBlockedCategoryNames() {
        let categories = CashFlowCategoryEntity.getAll(from: context)
        categoryModel.nameInput.settings.blocked.values = categories.map { $0.name }
    }
}
