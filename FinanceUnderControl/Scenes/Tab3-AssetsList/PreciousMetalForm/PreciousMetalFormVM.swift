//
//  PreciousMetalFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Combine
import Foundation
import SSUtils
import SSValidation

final class PreciousMetalFormVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<PreciousMetalFormCoordinator.Destination>()
        let didTapConfirm = DriverSubject<Void>()
        let didTapClose = DriverSubject<Void>()
    }

    @Published private(set) var availableMetals: [PreciousMetalType] = []
    @Published private(set) var wasEdited = false
    @Published var formModel: PreciousMetalFormModel

    let binding = Binding()
    let amountInputVM = DecimalInputVM(validator: .alwaysValid)
    let formType: PreciousMetalFormType
    private let service = PreciousMetalService.shared
    
    init(formType: PreciousMetalFormType, coordinator: CoordinatorProtocol? = nil) {
        self.formType = formType
        formModel = .init(for: formType)
        super.init(coordinator: coordinator)

        amountInputVM.result().map { $0 ?? 0 }.weakAssign(to: \.formModel.amount, on: self)

        if case let .edit(preciousMetal) = formType {
            amountInputVM.setValue(to: preciousMetal.ouncesAmount)
            formModel.amount = preciousMetal.ouncesAmount
        }

        let errorTracker = DriverSubject<Error>()
        let initialFormModel = formModel

        $formModel.map { $0 != initialFormModel }.assign(to: &$wasEdited)

        errorTracker.sinkAndStore(on: self) { _, error in
            print(error)
        }

        binding.didTapClose
            .map(with: self) { vm, _ in !vm.wasEdited }
            .sinkAndStore(on: self) { vm, canBeClosed in
                vm.binding.navigateTo.send(canBeClosed ? .dismiss : .askToDismiss)
            }

        CombineLatest(Just(PreciousMetalType.allCases), service.$preciousMetals)
            .map { result in
                let createdPreciousMetals = result.1.map { $0.type }
                return result.0.filter { createdPreciousMetals.notContains($0) }
            }
            .assign(to: &$availableMetals)

        let didTapConfirm = binding.didTapConfirm
            .withLatestFrom($formModel)
            .compactMap { $0 }

        didTapConfirm
            .filter { $0 == initialFormModel }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }

        didTapConfirm
            .filter { $0 != initialFormModel }
            .compactMap { $0.model(for: formType) }
            .perform(on: self, isLoading: mainLoader, errorTracker: errorTracker) { vm, newWallet in
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
