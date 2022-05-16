//
//  CashFlowCategoryGroupFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import Foundation
import Shared
import SSValidation
import SSUtils

final class CashFlowCategoryGroupFormVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlowCategoryGroup>

    struct Binding {
        let navigateTo = DriverSubject<CashFlowCategoryGroupFormCoordinator.Destination>()
        let confirmGroupDeletion = DriverSubject<Void>()
        let didTapConfirm = DriverSubject<Void>()
    }

    @Published var formModel: CashFlowCategoryGroupFormModel

    let binding = Binding()
    let formType: FormType
    let nameInput = TextInputVM()

    private let groupService = CashFlowCategoryGroupService()
    private let categoryService = CashFlowCategoryService()

    init(for formType: FormType, coordinator: Coordinator) {
        self.formType = formType
        self.formModel = .init(type: formType.cashFlowType)
        super.init(coordinator: coordinator)

        nameInput.result().weakAssign(to: \.formModel.name, on: self)

        let initialFormModel: CashFlowCategoryGroupFormModel?

        if case let .edit(group) = formType {
            nameInput.setText(to: group.name)
            formModel = .init(from: group)
            initialFormModel = formModel
        } else {
            initialFormModel = nil
        }

        let didTapConfirm = binding.didTapConfirm.withLatestFrom($formModel)

        didTapConfirm
            .filter { $0 == initialFormModel }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }

        didTapConfirm
            .filter { $0 != initialFormModel }
            .compactMap { $0.model(for: formType) }
            .perform(on: self) { [weak self] in
                guard let self = self else { return }
                let categories = self.formModel.categoriesToUpdate(to: $0)
                try await self.groupService.createOrEdit($0)
                try await self.categoryService.createOrEdit(categories)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }

        binding.confirmGroupDeletion
            .perform(on: self) { [weak self] in
                guard case let .edit(group) = formType else { return }
                try await self?.groupService.delete(group)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
