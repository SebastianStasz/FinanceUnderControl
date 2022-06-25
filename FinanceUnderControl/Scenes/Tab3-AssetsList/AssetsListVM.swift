//
//  AssetsListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Combine
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
    private let preciousMetals = Just([PreciousMetal(type: .XAU, ouncesAmount: 2)])

    override func viewDidLoad() {
        let primaryCurrency = PersistentStorage.primaryCurrency
        let wallets = storage.$wallets

        let walletAssets = wallets.map {
            $0.map { Asset.wallet($0, moneyPrimaryCurrency: $0.money.convert(to: primaryCurrency)) }
        }
        let preciousMetalAssets = preciousMetals.map {
            $0.map { Asset.preciousMetal($0, moneyPrimaryCurrency: $0.moneyInCurrency(primaryCurrency)) }
        }

        CombineLatest(walletAssets, preciousMetalAssets)
            .map { $0.0.map { $0.moneyPrimaryCurrency }.sum() + $0.1.map { $0.moneyPrimaryCurrency }.sum() }
            .assign(to: &$totalBalance)

        let walletAssetsVD = CombineLatest(walletAssets, $totalBalance)
            .map { result in result.0.map { AssetVD(from: $0, total: result.1) } }

        let preciousMetalsAssetsVD = CombineLatest(preciousMetalAssets, $totalBalance)
            .map { result in result.0.map { AssetVD(from: $0, total: result.1) } }

        let sectors = CombineLatest(walletAssetsVD, preciousMetalsAssetsVD)
            .map { [ListSector(.common_wallets, elements: $0.0), .init(.common_precious_metals, elements: $0.1)] }

        let listOutput = listVM.transform(input: .init(sectors: sectors.asDriver))
        listOutput.viewData.assign(to: &$listVD)
    }
}

extension Money {
    func convert(to currency: Currency) -> Money? {
        guard currency != self.currency else { return self }
        guard let currencyEntity = CurrencyEntity.get(withCode: self.currency.code, from: AppVM.shared.context),
              let rateValue = currencyEntity.getExchangeRate(for: currency.code)?.rateValue
        else { return nil }
        return Money(rateValue * value, currency: currency)
    }
}
