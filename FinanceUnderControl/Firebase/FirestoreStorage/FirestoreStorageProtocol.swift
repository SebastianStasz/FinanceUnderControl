//
//  FirestoreStorageProtocol.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/06/2022.
//

import Shared
import SSUtils

protocol FirestoreStorageProtocol: CombineHelper {
    var wallets: Driver<[Wallet]> { get }
    var currentWallets: [Wallet] { get }

    var preciousMetals: Driver<[PreciousMetal]> { get }
    var currentPreciousMetals: [PreciousMetal] { get }

    var groups: Driver<[CashFlowCategoryGroup]> { get }
    var currentGroups: [CashFlowCategoryGroup] { get }
    func groups(ofType type: CashFlowType) -> Driver<[CashFlowCategoryGroup]>
    func currentGroups(ofType type: CashFlowType) -> [CashFlowCategoryGroup]

    var categories: Driver<[CashFlowCategory]> { get }
    var currentCategories: [CashFlowCategory] { get }
    func categories(ofType type: CashFlowType) -> Driver<[CashFlowCategory]>
    func currentCategories(ofType type: CashFlowType) -> [CashFlowCategory]
}
