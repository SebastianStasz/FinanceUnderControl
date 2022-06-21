//
//  AssetsListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import FinanceCoreData
import Foundation
import Shared
import SSUtils

final class AssetsListVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<AssetsListCoordinator.Destination>()
    }

    @Published private(set) var listVD = BaseListVD<AssetVD>.initialState
    @Published private(set) var totalBalance: Money?

    let binding = Binding()
    let listVM = BaseListVM<AssetVD>()
    private var storage = WalletService.shared

    override func viewDidLoad() {
        let primaryCurrency = PersistentStorage.primaryCurrency
        let wallets = storage.$wallets

        let totalBalance = wallets.map {
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

        let walletAssets = CombineLatest(wallets, totalBalance).map { result in
            result.0.map { AssetVD(from: $0, total: result.1) }
        }

        let sectors = walletAssets
            .map { [ListSector("Wallets", elements: $0)] }

        let listOutput = listVM.transform(input: .init(sectors: sectors.asDriver))
        listOutput.viewData.assign(to: &$listVD)

        totalBalance.map {
            guard let balance = $0 else { return nil }
            return Money(balance, currency: primaryCurrency)
        }
        .assign(to: &$totalBalance)
    }
}

extension Money {
    func value(in currency: Currency) -> Money? {
        guard currency != self.currency else { return self }
        guard let currencyEntity = CurrencyEntity.get(withCode: self.currency.code, from: AppVM.shared.context),
              let rateValue = currencyEntity.getExchangeRate(for: currency.code)?.rateValue
        else { return nil }
        return Money(rateValue * value, currency: currency)
    }
}
