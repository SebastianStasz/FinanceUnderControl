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
        let didTapClose = DriverSubject<Void>()
    }

    private let service: CashFlowService
    private let storage = Database.shared.grouping
    let formType: FormType
    let binding = Binding()
    var nameInput = TextInputVM()
    var valueInput = DecimalInputVM()

    @Published private(set) var categories: [CashFlowCategory] = []
    @Published private(set) var wasEdited = false
    @Published var formModel: CashFlowFormModel

    init(for formType: FormType, coordinator: CoordinatorProtocol, service: CashFlowService = .init()) {
        self.formType = formType
        self.service = service
        formModel = .init(type: formType.cashFlowType)
        super.init(coordinator: coordinator)

        storage.categoriesSubscription(type: formType.cashFlowType).assign(to: &$categories)
        nameInput.result().weakAssign(to: \.formModel.name, on: self)
        valueInput.result().weakAssign(to: \.formModel.value, on: self)

        if case let .edit(cashFlow) = formType {
            nameInput.setText(to: cashFlow.name)
            valueInput.setValue(to: cashFlow.money.value)
            formModel = cashFlow.formModel
        }

        let errorTracker = DriverSubject<Error>()
        let initialFormModel = formModel

        $formModel.map { $0 != initialFormModel }.assign(to: &$wasEdited)

        binding.didTapClose
            .map(with: self) { vm, _ in !vm.wasEdited }
            .sinkAndStore(on: self) { vm, canBeClosed in
                vm.binding.navigateTo.send(canBeClosed ? .dismiss : .askToDismiss)
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
            .compactMap { $0.model(for: formType) }
            .perform(isLoading: mainLoader, errorTracker: errorTracker) {
                try await service.createOrEdit($0)
            }
            .sinkAndStore(on: self) { vm, _ in
                AppVM.shared.events.didChangeCashFlow.send()
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
