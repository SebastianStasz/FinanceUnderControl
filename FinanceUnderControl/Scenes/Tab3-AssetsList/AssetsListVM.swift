//
//  AssetsListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import FinanceCoreData
import Foundation
import SSUtils

final class AssetsListVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<AssetsListCoordinator.Destination>()
    }

    @Published private(set) var walletsListVD = BaseListVD<Wallet>.initialState
    @Published private(set) var totalBalance: Decimal?

    let binding = Binding()
    let walletsListVM = BaseListVM<Wallet>()
    private var storage = WalletService.shared

    override func viewDidLoad() {
        let wallets = storage.$wallets.map { [ListSector("Wallets", elements: $0)] }.asDriver
        let listOutput = walletsListVM.transform(input: .init(sectors: wallets))
        listOutput.viewData.assign(to: &$walletsListVD)

        let primaryCurrency = PersistentStorage.primaryCurrency

        storage.$wallets.map {
            $0.map { wallet -> Decimal? in
                guard wallet.currency != primaryCurrency else { return wallet.balance }
                guard let currency = CurrencyEntity.get(withCode: wallet.currency.code, from: AppVM.shared.context),
                      let exchangeRate = currency.getExchangeRate(for: primaryCurrency.code)
                else { return nil }
                return wallet.balance * exchangeRate.rateValue
            }
        }
        .map { balances -> Decimal? in
            guard balances.notContains(nil) else { return nil }
            return balances.compactMap { $0 }.reduce(0, +)
        }
        .assign(to: &$totalBalance)
    }
}
