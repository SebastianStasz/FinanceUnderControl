//
//  UserDefaults+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 11/12/2021.
//

import Foundation

extension UserDefaults {

    static func string(forKey key: UserDefaultsKey) -> String? {
        standard.string(forKey: key.rawValue)
    }

    static func set(value: Any?, forKey key: UserDefaultsKey) {
        standard.set(value, forKey: key.rawValue)
    }
}
