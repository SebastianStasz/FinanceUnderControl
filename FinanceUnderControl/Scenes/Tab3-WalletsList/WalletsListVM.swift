//
//  WalletsListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation

final class WalletsListVM: ViewModel {

    @Published private(set) var wallets: [Wallet] = []

    private var storage = Database.shared.wallets

    override func viewDidLoad() {
        storage.$wallets.assign(to: &$wallets)
    }
}
