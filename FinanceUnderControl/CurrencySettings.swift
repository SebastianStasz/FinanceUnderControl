//
//  CurrencySettings.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 11/12/2021.
//

import Combine
import CoreData
import Foundation
import FinanceCoreData
import SSUtils

final class CurrencySettings {

    struct Output {
        let primaryCurrency: Driver<CurrencyEntity?>
        let secondaryCurrency: Driver<CurrencyEntity?>
    }

    private var cancellables: Set<AnyCancellable> = []
    private let context: NSManagedObjectContext
    @Published var currencySelector: CurrencySelector<String>

    init(context: NSManagedObjectContext = AppVM.shared.context) {
        self.context = context
        currencySelector = .init(primaryCurrency: CurrencySettings.getPrimaryCurrencyCode(),
                                 secondaryCurrency: CurrencySettings.getSecondaryCurrencyCode())
        $currencySelector
            .dropFirst()
            .sink { CurrencySettings.savePrimaryCurrency(to: $0.primaryCurrency) }
            .store(in: &cancellables)

        $currencySelector
            .dropFirst()
            .sink { CurrencySettings.saveSecondaryCurrency(to: $0.secondaryCurrency) }
            .store(in: &cancellables)
    }

    func bind() -> Output {
        let primaryCurrency = $currencySelector
            .map { [weak self] selector -> CurrencyEntity? in
                guard let context = self?.context else { return nil }
                return CurrencyEntity.get(withCode: selector.primaryCurrency, from: context)
            }
            .receive(on: DispatchQueue.main)

        let secondaryCurrency = $currencySelector
            .map { [weak self] selector -> CurrencyEntity? in
                guard let context = self?.context else { return nil }
                return CurrencyEntity.get(withCode: selector.secondaryCurrency, from: context)
            }
            .receive(on: DispatchQueue.main)

        return Output(primaryCurrency: primaryCurrency.asDriver,
                      secondaryCurrency: secondaryCurrency.asDriver
        )
    }
}

// MARK: - Helpers

private extension CurrencySettings {

    static func getPrimaryCurrencyCode() -> String {
        guard let currency = UserDefaults.string(forKey: .primaryCurrency) else {
            savePrimaryCurrency(to: "PLN")
            return getPrimaryCurrencyCode()
        }
        return currency
    }

    static func getSecondaryCurrencyCode() -> String {
        guard let currency = UserDefaults.string(forKey: .secondaryCurrency) else {
            saveSecondaryCurrency(to: "EUR")
            return getSecondaryCurrencyCode()
        }
        return currency
    }

    static func savePrimaryCurrency(to code: String) {
        UserDefaults.set(value: code, forKey: .primaryCurrency)
    }

    static func saveSecondaryCurrency(to code: String) {
        UserDefaults.set(value: code, forKey: .secondaryCurrency)
    }
}
