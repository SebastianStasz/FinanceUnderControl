//
//  ExchangeRateListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 03/12/2021.
//

import Combine
import FinanceCoreData
import Foundation

final class ExchangeRateListVM: ViewModel {

    private let currencyEntity: CurrencyEntity
    let listVM = BaseListVM<ExchangeRateEntity>()

    @Published private(set) var listVD = BaseListVD<ExchangeRateEntity>.initialState

    init(currencyEntity: CurrencyEntity) {
        self.currencyEntity = currencyEntity
        super.init(coordinator: nil)
    }

    override func viewDidLoad() {
        let exchangeRates = Just(currencyEntity.exchangeRatesArray).asDriver
        let listOutput = listVM.transform(input: .init(elements: exchangeRates))
        listOutput.viewData.assign(to: &$listVD)
    }
}
