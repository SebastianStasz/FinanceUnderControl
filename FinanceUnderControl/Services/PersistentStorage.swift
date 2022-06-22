//
//  PersistentStorage.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation
import Shared

struct PersistentStorage {
    static var appTheme: AppTheme {
        let key = UserDefaults.string(forKey: .appTheme) ?? AppTheme.system.rawValue
        return AppTheme(rawValue: key) ?? .system
    }

    static var primaryCurrency: Currency {
        let code = UserDefaults.string(forKey: .primaryCurrency) ?? Currency.PLN.code
        return Currency(rawValue: code) ?? .PLN
    }

    static var secondaryCurrency: Currency {
        let code = UserDefaults.string(forKey: .secondaryCurrency) ?? Currency.EUR.code
        return Currency(rawValue: code) ?? .PLN
    }
}
