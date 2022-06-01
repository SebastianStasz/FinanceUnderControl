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
    }

    @Published var formModel = CashFlowCategoryFormModel()

    let formType: FormType
    let binding = Binding()
    let nameInput = TextInputVM()

    private let service = CashFlowCategoryService()

    init(for formType: FormType, coordinator: Coordinator?) {
        self.formType = formType
        super.init(coordinator: coordinator)

        let initialFormModel: CashFlowCategoryFormModel?
        let errorTracker = DriverSubject<Error>()

        nameInput.$resultValue.weakAssign(to: \.formModel.name, on: self)

        if case let .edit(category) = formType {
            nameInput.setText(to: category.name)
            formModel = category.formModel
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
            .perform(on: self, isLoading: mainLoader, errorTracker: errorTracker) { vm, category in
                try await vm.service.createOrEdit(category)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
