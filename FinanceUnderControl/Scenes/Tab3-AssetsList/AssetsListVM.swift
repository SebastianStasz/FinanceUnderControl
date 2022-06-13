//
//  AssetsListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation

final class AssetsListVM: ViewModel {

    @Published private(set) var walletsListVD = BaseListVD<Wallet>.initialState

    let walletsListVM = BaseListVM<Wallet>()
    private var storage = Database.shared.wallets

    override func viewDidLoad() {
        let wallets = storage.$wallets.map { [ListSector("Wallets", elements: $0)] }.asDriver
        let listOutput = walletsListVM.transform(input: .init(sectors: wallets))
        listOutput.viewData.assign(to: &$walletsListVD)
    }
}
