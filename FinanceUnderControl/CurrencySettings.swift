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
    @Published var currencySelector: CurrencySelector<String?>

    init(context: NSManagedObjectContext = AppVM.shared.context) {
        self.context = context
        currencySelector = .init(primaryCurrency: CurrenciesProvider.primaryCurrencyCode,
                                 secondaryCurrency: CurrenciesProvider.secondaryCurrencyCode)
        $currencySelector
            .dropFirst()
            .compactMap { $0.primaryCurrency }
            .sink { CurrencySettings.savePrimaryCurrency(to: $0) }
            .store(in: &cancellables)

        $currencySelector
            .dropFirst()
            .compactMap { $0.secondaryCurrency }
            .sink { CurrencySettings.saveSecondaryCurrency(to: $0) }
            .store(in: &cancellables)
    }

    func bind() -> Output {
        let primaryCurrency = $currencySelector
            .compactMap { $0.primaryCurrency }
            .map { [weak self] primaryCurrency -> CurrencyEntity? in
                guard let context = self?.context else { return nil }
                return CurrencyEntity.get(withCode: primaryCurrency, from: context)
            }
            .receive(on: DispatchQueue.main)

        let secondaryCurrency = $currencySelector
            .compactMap { $0.secondaryCurrency }
            .map { [weak self] secondaryCurrency -> CurrencyEntity? in
                guard let context = self?.context else { return nil }
                return CurrencyEntity.get(withCode: secondaryCurrency, from: context)
            }
            .receive(on: DispatchQueue.main)

        return Output(primaryCurrency: primaryCurrency.asDriver,
                      secondaryCurrency: secondaryCurrency.asDriver
        )
    }
}

// MARK: - Helpers

private extension CurrencySettings {

    static func savePrimaryCurrency(to code: String) {
        UserDefaults.set(value: code, forKey: .primaryCurrency)
    }

    static func saveSecondaryCurrency(to code: String) {
        UserDefaults.set(value: code, forKey: .secondaryCurrency)
    }
}
