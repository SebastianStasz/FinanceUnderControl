//
//  String+Localization.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

public extension String {

    /// Returns a localized string, using the main bundle.
    private func localize() -> String {
        NSLocalizedString(self, bundle: .main, comment: self)
    }

    /// Returns a localized string with a parameter, using the main bundle.
    private func localize(parameter: String) -> String {
        String(format: self.localize(), parameter)
    }

    // MARK: - Tab

    static let tab_dashboard_title = "tab_dashboard_title".localize()
    static let tab_cashFlow_title = "tab_cashFlow_title".localize()
    static let tab_currencies_title = "tab_currencies_title".localize()
    static let tab_settings_title = "tab_settings_title".localize()

    // MARK: - Button
    
    static let button_apply = "button_apply".localize()
    static let button_reset = "button_reset".localize()
    static let button_create = "button_create".localize()

    // MARK: - Common

    static let common_all = "common_all".localize()
    static let common_none = "common_none".localize()
    static let common_info = "common_info".localize()
    static let common_amount = "common_amount".localize()
    static let common_categories = "common_categories".localize()
    static let common_currencies = "common_currencies".localize()
    static let common_expenses = "common_expenses".localize()
    static let common_incomes = "common_incomes".localize()
    static let common_primary = "common_primary".localize()
    static let common_secondary = "common_secondary".localize()
    static let common_exchange_rate = "common_exchange_rate".localize()
    static let common_category = "common_category".localize()

    // MARK: - Cash flow filter

    static let cash_flow_filter_title = "cash_flow_filter_title".localize()
    static let cash_flow_filter_type = "cash_flow_filter_type".localize()
    static let cash_flow_filter_date_range = "cash_flow_filter_date_range".localize()
    static let cash_flow_filter_date_start = "cash_flow_filter_date_start".localize()
    static let cash_flow_filter_date_end = "cash_flow_filter_date_end".localize()
    static let cash_flow_filter_minimum_value = "cash_flow_filter_minimum_value".localize()
    static let cash_flow_filter_maximum_value = "cash_flow_filter_maximum_value".localize()

    // MARK: - Create cash flow

    static let create_cash_flow_name = "create_cash_flow_name".localize()
    static let create_cash_flow_currency = "create_cash_flow_currency".localize()
    static let create_cash_flow_date = "create_cash_flow_date".localize()
    static let create_cash_flow_income = "create_cash_flow_income".localize()
    static let create_cash_flow_expense = "create_cash_flow_expense".localize()

    // MARK: - Cantor

    static let cantor_from = "cantor_from".localize()
    static let cantor_to = "cantor_to".localize()
    static let cantor_converter = "cantor_converter".localize()
    static let cantor_exchange_rates_info_message = "cantor_exchange_rates_info_message".localize()

    static func cantor_all_exchange_rates(forCurrency currency: String) -> String {
        "cantor_all_exchange_rates".localize(parameter: currency)
    }

    static func cantor_load_exchange_rates_error_message(forCurrency currency: String) -> String {
        "cantor_load_exchange_rates_error_message".localize(parameter: currency)
    }

    static let cannot_delete_cash_flow_category_message = "cannot_delete_cash_flow_category_message".localize()
}
