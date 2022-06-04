//
//  String+Localization.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

// swiftlint:disable all
public extension String {

    /// Returns a localized string, using the main bundle.
    func localize() -> String {
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
    static let common_groups = "common_groups".localize()
    static let common_currencies = "common_currencies".localize()
    static let common_expenses = "common_expenses".localize()
    static let common_incomes = "common_incomes".localize()
    static let common_expense = "common_expense".localize()
    static let common_income = "common_income".localize()
    static let common_primary = "common_primary".localize()
    static let common_secondary = "common_secondary".localize()
    static let common_exchange_rate = "common_exchange_rate".localize()
    static let common_category = "common_category".localize()
    static let common_edit = "common_edit".localize()
    static let common_done = "common_done".localize()
    static let common_save = "common_save".localize()
    static let common_color = "common_color".localize()
    static let common_icon = "common_icon".localize()
    static let common_include = "common_include".localize()
    static let common_import = "common_import".localize()
    static let common_export = "common_export".localize()
    static let common_file_name = "common_file_name".localize()
    static let common_more = "common_more".localize()
    static let common_error = "common_error".localize()
    static let common_add = "common_add".localize()
    static let common_delete = "common_delete".localize()
    static let common_cancel = "common_cancel".localize()
    static let common_discard_changes = "common_discard_changes".localize()

    // MARK: - Authorization

    static let authorization_register_success_title = "authorization_register_success_title".localize()
    static let authorization_register_success_message = "authorization_register_success_message".localize()
    static let authorization_register_account_exists_title = "authorization_register_account_exists_title".localize()
    static let authorization_register_account_exists_message = "authorization_register_account_exists_message".localize()
    static let authorization_register_account_invalid_email_title = "authorization_register_account_invalid_email_title".localize()
    static let authorization_register_account_invalid_email_message = "authorization_register_account_invalid_email".localize()
    static let authorization_register_account_unknown_error_message = "authorization_register_account_unknown_error_message".localize()

    // MARK: - Cash flow filter

    static let cash_flow_filter_title = "cash_flow_filter_title".localize()
    static let cash_flow_filter_type = "cash_flow_filter_type".localize()
    static let cash_flow_filter_other = "cash_flow_filter_other".localize()
    static let cash_flow_filter_date_range = "cash_flow_filter_date_range".localize()
    static let cash_flow_filter_date_start = "cash_flow_filter_date_start".localize()
    static let cash_flow_filter_date_end = "cash_flow_filter_date_end".localize()
    static let cash_flow_filter_minimum_value = "cash_flow_filter_minimum_value".localize()
    static let cash_flow_filter_maximum_value = "cash_flow_filter_maximum_value".localize()

    // MARK: - Create cash flow

    static let cash_flow_add_income = "cash_flow_add_income".localize()
    static let cash_flow_add_expense = "cash_flow_add_expense".localize()
    static let cash_flow_edit_income = "cash_flow_edit_income".localize()
    static let cash_flow_edit_expense = "cash_flow_edit_expense".localize()
    static let create_cash_flow_name = "create_cash_flow_name".localize()
    static let create_cash_flow_currency = "create_cash_flow_currency".localize()
    static let create_cash_flow_date = "create_cash_flow_date".localize()
    static let create_cash_flow_income = "create_cash_flow_income".localize()
    static let create_cash_flow_expense = "create_cash_flow_expense".localize()
    static let create_cash_flow_basic_label = "create_cash_flow_basic_label".localize()
    static let create_cash_flow_more_label = "create_cash_flow_more_label".localize()

    // MARK: - Cantor

    static let cantor_from = "cantor_from".localize()
    static let cantor_to = "cantor_to".localize()
    static let cantor_converter = "cantor_converter".localize()
    static let cantor_base_currency = "cantor_base_currency".localize()
    static let cantor_fill_in_form_error_message = "cantor_fill_in_form_error_message".localize()
    static let cantor_exchange_rates_info_message = "cantor_exchange_rates_info_message".localize()

    static func cantor_all_exchange_rates(forCurrency currency: String) -> String {
        "cantor_all_exchange_rates".localize(parameter: currency)
    }

    static func cantor_load_exchange_rates_error_message(forCurrency currency: String) -> String {
        "cantor_load_exchange_rates_error_message".localize(parameter: currency)
    }

    // MARK: - Settings

    static let settings_create_group = "settings_create_group".localize()
    static let settings_create_category = "settings_create_category".localize()
    static let settings_edit_group = "settings_edit_group".localize()
    static let settings_edit_category = "settings_edit_category".localize()
    static let settings_select_action = "settings_select_action".localize()
    static let settings_your_finance_data = "settings_your_finance_data".localize()
    static let settings_import_finance_data_description = "settings_import_finance_data_description".localize()
    static let settings_import_finance_data_result_description = "settings_import_finance_data_result_description".localize()
    static let settings_export_finance_data_description = "settings_export_finance_data_description".localize()

    static let cannot_delete_cash_flow_category_message = "cannot_delete_cash_flow_category_message".localize()

    // MARK: - Currency

    static let currency_BYN = "currency_BYN".localize()
    static let currency_EUR = "currency_EUR".localize()
    static let currency_GBP = "currency_GBP".localize()
    static let currency_PLN = "currency_PLN".localize()
    static let currency_RUB = "currency_RUB".localize()
    static let currency_UAH = "currency_UAH".localize()
    static let currency_USD = "currency_USD".localize()

    // MARK: - Empty state

    static let empty_state_search_title = "empty_state_search_title".localize()
    static let empty_state_search_description = "empty_state_search_description".localize()

    // MARK: - Validation

    static let validation_no_elements_available = "validation_no_elements_available".localize()
    static let validation_invalid_email = "validation_invalid_email".localize()
}
