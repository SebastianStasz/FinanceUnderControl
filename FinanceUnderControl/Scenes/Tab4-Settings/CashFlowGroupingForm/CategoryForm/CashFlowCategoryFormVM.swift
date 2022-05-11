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

    init(for formType: FormType, coordinator: Coordinator) {
        self.formType = formType
        super.init(coordinator: coordinator)

        let errorTracker = DriverSubject<Error>()

        nameInput.$resultValue.weakAssign(to: \.formModel.name, on: self)

        binding.didTapConfirm
            .withLatestFrom($formModel)
            .compactMap { $0.model(for: formType) }
            .perform(on: self, errorTracker: errorTracker) { [weak self] in
                try await self?.service.create($0)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.createdSuccessfully)
            }
    }
}
