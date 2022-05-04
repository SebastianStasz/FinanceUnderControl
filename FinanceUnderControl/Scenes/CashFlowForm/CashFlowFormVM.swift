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

    struct Binding {
        let didTapConfirm = DriverSubject<Void>()
        let createdSuccessfully = DriverSubject<Void>()
    }

    private let service: CashFlowService
    let binding = Binding()
    var nameInput = TextInputVM()
    var valueInput = DecimalInputVM()

    @Published var formModel = CashFlowFormModel()
    let formType: CashFlowForm

    init(for formType: CashFlowForm, coordinator: CoordinatorProtocol, service: CashFlowService = .init()) {
        self.formType = formType
        self.service = service
        super.init(coordinator: coordinator)

        nameInput.result().weakAssign(to: \.formModel.name, on: self)
        valueInput.result().weakAssign(to: \.formModel.value, on: self)

        let errorTracker = DriverSubject<Error>()

        binding.didTapConfirm
            .withLatestFrom($formModel)
            .compactMap { $0.model }
            .perform(on: self, errorTracker: errorTracker) {
                try await service.create(model: $0)
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.createdSuccessfully.send()
            }
//
//        errorTracker
//            .sinkAndStore(on: self) { vm, error in
//                print(error)
//            }
    }
}
