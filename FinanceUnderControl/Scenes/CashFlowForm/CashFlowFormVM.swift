//
//  CashFlowFormVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import Combine
import Foundation
import SSValidation
import Shared
import SSUtils
import FinanceCoreData
import FirebaseFirestore
import FirebaseAuth

final class CashFlowFormVM: ViewModel {
    typealias FormType = CashFlowFormType<CashFlow>

    struct Binding {
        let navigateTo = DriverSubject<CashFlowFormCoordinator.Destination>()
        let didTapConfirm = DriverSubject<Void>()
    }

    private let service: CashFlowService
    private let storage = CashFlowGroupingService.shared
    let formType: FormType
    let binding = Binding()
    var nameInput = TextInputVM()
    var valueInput = DecimalInputVM()

    @Published private(set) var categories: [CashFlowCategory] = []
    @Published var formModel = CashFlowFormModel()

    init(for formType: FormType,
         coordinator: CoordinatorProtocol,
         service: CashFlowService = .init()
    ) {
        self.formType = formType
        self.service = service
        super.init(coordinator: coordinator)

        storage.$categories.assign(to: &$categories)

        nameInput.result().weakAssign(to: \.formModel.name, on: self)
        valueInput.result().weakAssign(to: \.formModel.value, on: self)

        let initialFormModel: CashFlowFormModel?
        let errorTracker = DriverSubject<Error>()

        if case let .edit(cashFlow) = formType {
            formModel = cashFlow.formModel
            initialFormModel = formModel
        } else {
            initialFormModel = nil
        }

        let didTapConfirm = binding.didTapConfirm
            .withLatestFrom($formModel)

        didTapConfirm
            .filter { $0 == initialFormModel }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }

        didTapConfirm
            .filter { $0 != initialFormModel }
            .compactMap { $0.model }
            .perform(on: self, errorTracker: errorTracker) {
                try await service.createOrEdit($0)
            }
            .sinkAndStore(on: self) { vm, _ in
                AppVM.shared.events.didChangeCashFlow.send()
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
