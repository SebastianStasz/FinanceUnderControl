//
//  CashFlowCategoryFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import Foundation
import Shared
import SSUtils
import SSValidation

final class CashFlowCategoryFormVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlowCategory>

    struct Binding {
        let navigateTo = DriverSubject<CashFlowCategoryFormCoordinator.Destination>()
        let didTapConfirm = DriverSubject<Void>()
        let didTapClose = DriverSubject<Void>()
    }

    @Published var formModel = CashFlowCategoryFormModel()
    @Published private(set) var wasEdited = false

    let formType: FormType
    let binding = Binding()
    let nameInput = TextInputVM()

    private let service = CashFlowCategoryService()

    init(for formType: FormType, coordinator: Coordinator?) {
        self.formType = formType
        super.init(coordinator: coordinator)

        nameInput.$resultValue.weakAssign(to: \.formModel.name, on: self)

        if case let .edit(category) = formType {
            nameInput.setText(to: category.name)
            formModel = category.formModel
        }

        let initialFormModel = formModel
        let errorTracker = DriverSubject<Error>()
        let didTapConfirm = binding.didTapConfirm.withLatestFrom($formModel)

        $formModel.map { $0 != initialFormModel }.assign(to: &$wasEdited)

        binding.didTapClose
            .map(with: self) { vm, _ in !vm.wasEdited }
            .sinkAndStore(on: self) { vm, canBeClosed in
                vm.binding.navigateTo.send(canBeClosed ? .dismiss : .askToDismiss)
            }

        didTapConfirm
            .filter { $0 == initialFormModel }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }

        didTapConfirm
            .filter { $0 != initialFormModel }
            .compactMap { $0.model(for: formType) }
            .perform(on: self, isLoading: mainLoader, errorTracker: errorTracker) { vm, category in
                try await vm.service.createOrEdit(category)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
