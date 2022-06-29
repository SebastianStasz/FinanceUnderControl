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
    private let storage: FirestoreStorageProtocol

    init(storage: FirestoreStorageProtocol = FirestoreStorage.shared, coordinator: CoordinatorProtocol? = nil) {
        self.storage = storage
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let primaryCurrency = PersistentStorage.primaryCurrency
        let wallets = storage.wallets
        let preciousMetals = storage.preciousMetals

        let walletAssets = wallets.map {
            $0.map { Asset.wallet($0, moneyPrimaryCurrency: $0.money.convert(to: primaryCurrency)) }
        }
        let preciousMetalAssets = preciousMetals.map {
            $0.map { Asset.preciousMetal($0, moneyPrimaryCurrency: $0.moneyInCurrency(primaryCurrency)) }
        }

        CombineLatest(walletAssets, preciousMetalAssets)
            .map {
                let zeroMoney = Money(0, currency: primaryCurrency)
                let walletsTotal = $0.0.isEmpty ? zeroMoney : $0.0.map { $0.moneyPrimaryCurrency }.sum()
                let preciousMetalsTotal = $0.1.isEmpty ? zeroMoney : $0.1.map { $0.moneyPrimaryCurrency }.sum()
                return walletsTotal + preciousMetalsTotal
            }
            .assign(to: &$totalBalance)

        let walletAssetsVD = CombineLatest(walletAssets, $totalBalance)
            .map { result in result.0.map { AssetVD(from: $0, total: result.1) } }

        let preciousMetalsAssetsVD = CombineLatest(preciousMetalAssets, $totalBalance)
            .map { result in result.0.map { AssetVD(from: $0, total: result.1) } }

        let sectors = CombineLatest(walletAssetsVD, preciousMetalsAssetsVD)
            .map {
                var sectors: [ListSector<AssetVD>] = []
                if $0.0.isNotEmpty {
                    sectors.append(.init(.asset_wallets, elements: $0.0))
                }
                if $0.1.isNotEmpty {
                    sectors.append(.init(.asset_precious_metals, elements: $0.1))
                }
                return sectors
            }

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
