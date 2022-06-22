//
//  AppTheme.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 22/06/2022.
//

import UIKit
import Shared

enum AppTheme: String, CaseIterable, Pickerable {
    case system
    case light
    case dark

    var name: String {
        switch self {
        case .system:
            return .app_theme_system_name
        case .light:
            return .app_theme_light_name
        case .dark:
            return .app_theme_dark_name
        }
    }

    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    var valueName: String { name }
}
