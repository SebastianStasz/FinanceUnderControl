//
//  String+Localization.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

public extension String {

    /// Returns a localized string, using the main bundle.
    func localize() -> String {
        NSLocalizedString(self, bundle: .main, comment: self)
    }

    static let tab_dashboard_title = "tab_dashboard_title".localize()
    static let tab_cashFlow_title = "tab_cashFlow_title".localize()
    static let tab_currencies_title = "tab_currencies_title".localize()
    static let tab_settings_title = "tab_settings_title".localize()
}
