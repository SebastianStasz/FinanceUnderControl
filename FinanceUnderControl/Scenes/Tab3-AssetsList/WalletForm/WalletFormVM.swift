//
//  WalletFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Combine
import Foundation
import Shared
import SSUtils
import SSValidation

final class WalletFormVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<WalletFormCoordinator.Destination>()
        let didTapConfirm = DriverSubject<Void>()
        let didTapClose = DriverSubject<Void>()
    }

    @Published private(set) var availableCurrencies: [Currency] = []
    @Published private(set) var wasEdited = false
    @Published var formModel: WalletFormModel

    let binding = Binding()
    let balanceInputVM = DecimalInputVM(validator: .alwaysValid)
    let formType: WalletFormType
    private let service = WalletService()
    private let storage: FirestoreStorageProtocol

    init(formType: WalletFormType,
         storage: FirestoreStorageProtocol = FirestoreStorage.shared,
         coordinator: CoordinatorProtocol? = nil
    ) {
        self.formType = formType
        self.storage = storage
        formModel = .init(for: formType)
        super.init(coordinator: coordinator)

        balanceInputVM.result().map { $0 ?? 0 }.weakAssign(to: \.formModel.balance, on: self)

        if case let .edit(wallet) = formType {
            balanceInputVM.setValue(to: wallet.balance)
            formModel.balance = wallet.balance
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

        CombineLatest(Just(Currency.allCases), storage.wallets)
            .map { result in
                let usedCurrencies = result.1.map { $0.currency }
                return result.0.filter { usedCurrencies.notContains($0) }
            }
            .assign(to: &$availableCurrencies)

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
                switch formType {
                case .new:
                    try await vm.service.create(newWallet)
                case .edit(let wallet):
                    try await vm.service.setBalance(newWallet.balance, for: wallet)
                }
            }
            .sinkAndStore(on: self) { vm, _ in
                vm.binding.navigateTo.send(.dismiss)
            }
    }
}
