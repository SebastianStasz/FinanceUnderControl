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
        let didTapConfirm = DriverSubject<Void>()
        let dismiss = DriverSubject<Void>()
    }

    @Published private(set) var availableCurrencies: [Currency] = []
    @Published var formModel: WalletFormModel

    let binding = Binding()
    let balanceInputVM = DecimalInputVM()
    let formType: WalletFormType
    private let service = WalletService.shared

    init(formType: WalletFormType) {
        self.formType = formType
        formModel = .init(for: formType)
        super.init()

        if case let .edit(wallet) = formType {
            balanceInputVM.setValue(to: wallet.balance)
        }

        balanceInputVM.result().weakAssign(to: \.formModel.balance, on: self)

        let errorTracker = DriverSubject<Error>()
        let initialFormModel = formModel

        errorTracker.sinkAndStore(on: self) { _, error in
            print(error)
        }

        CombineLatest(Just(Currency.allCases), service.$wallets)
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
                vm.binding.dismiss.send()
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
                vm.binding.dismiss.send()
            }
    }
}
