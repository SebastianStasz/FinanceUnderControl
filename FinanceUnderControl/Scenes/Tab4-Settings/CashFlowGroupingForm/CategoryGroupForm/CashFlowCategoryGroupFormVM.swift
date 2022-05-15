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

    @Published var formModel = CashFlowCategroupFormModel()

    let binding = Binding()
    let formType: FormType
    let nameInput = TextInputVM()

    private let service = CashFlowCategoryGroupService()

    init(for formType: FormType, coordinator: Coordinator) {
        self.formType = formType
        super.init(coordinator: coordinator)

        nameInput.result().weakAssign(to: \.formModel.name, on: self)

        if case let .edit(group) = formType {
            nameInput.setText(to: group.name)
            formModel = group.formModel
        }

        binding.didTapConfirm
            .withLatestFrom($formModel)
            .compactMap { $0.model(for: formType) }
            .perform(on: self) { [weak self] in
                try await self?.service.createOrEdit($0)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }

        binding.confirmGroupDeletion
            .perform(on: self) { [weak self] in
                guard case let .edit(group) = formType else { return }
                try await self?.service.delete(group)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
