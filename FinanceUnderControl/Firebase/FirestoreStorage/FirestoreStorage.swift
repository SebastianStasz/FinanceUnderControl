//
//  FirestoreStorage.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/06/2022.
//

import Combine
import Shared
import SSUtils

final class FirestoreStorage: FirestoreStorageProtocol {
    static let shared = FirestoreStorage()
    var cancellables: Set<AnyCancellable> = []

    private let walletSubscription = WalletSubscription()
    private let preciousMetalSubscription = PreciousMetalSubscription()
    private let cashFlowCategoryGroupSubscription = CashFlowCategoryGroupSubscription()
    private let cashFlowCategorySubscription = CashFlowCategorySubscription()

    private init() {
        let isUserLoggedIn = AppVM.shared.output.isUserLoggedIn

        isUserLoggedIn.filter { $0 }
            .sinkAndStore(on: self) { vm, _ in
                vm.walletSubscription.subscribe()
                vm.preciousMetalSubscription.subscribe()
                vm.cashFlowCategoryGroupSubscription.subscribe()
                vm.cashFlowCategorySubscription.subscribe(groups: vm.groups)
            }

        isUserLoggedIn.filter { !$0 }
            .sinkAndStore(on: self) { vm, _ in
                vm.walletSubscription.unsubscribe()
                vm.preciousMetalSubscription.unsubscribe()
                vm.cashFlowCategoryGroupSubscription.unsubscribe()
                vm.cashFlowCategorySubscription.unsubscribe()
            }
    }

    var wallets: Driver<[Wallet]> {
        walletSubscription.$wallets.asDriver
    }

    var currentWallets: [Wallet] {
        walletSubscription.wallets
    }

    var preciousMetals: Driver<[PreciousMetal]> {
        preciousMetalSubscription.$preciousMetals.asDriver
    }

    var currentPreciousMetals: [PreciousMetal] {
        preciousMetalSubscription.preciousMetals
    }

    var groups: Driver<[CashFlowCategoryGroup]> {
        cashFlowCategoryGroupSubscription.$groups.asDriver
    }

    var currentGroups: [CashFlowCategoryGroup] {
        cashFlowCategoryGroupSubscription.groups
    }

    func groups(ofType type: CashFlowType) -> Driver<[CashFlowCategoryGroup]> {
        groups.map { $0.filter { $0.type == type } }.asDriver
    }

    func currentGroups(ofType type: CashFlowType) -> [CashFlowCategoryGroup] {
        currentGroups.filter { $0.type == type }
    }

    var categories: Driver<[CashFlowCategory]> {
        cashFlowCategorySubscription.$categories.asDriver
    }

    var currentCategories: [CashFlowCategory] {
        cashFlowCategorySubscription.categories
    }

    func categories(ofType type: CashFlowType) -> Driver<[CashFlowCategory]> {
        categories.map { $0.filter { $0.type == type } }.asDriver
    }

    func currentCategories(ofType type: CashFlowType) -> [CashFlowCategory] {
        currentCategories.filter { $0.type == type }
    }
}
