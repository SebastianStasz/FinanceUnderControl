//
//  TabBarModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Foundation
import SwiftUI
import Shared

enum TabBarModel {
    case dashboard
    case cashFlow
    case currencies
    case settings

    var name: String {
        switch self {
        case .dashboard:
            return .tab_dashboard_title
        case .cashFlow:
            return .tab_cashFlow_title
        case .currencies:
            return .tab_currencies_title
        case .settings:
            return .tab_settings_title
        }
    }

    var icon: SFSymbol {
        switch self {
        case .dashboard:
            return SFSymbol.dashboardTab
        case .cashFlow:
            return SFSymbol.cashFlowTab
        case .currencies:
            return SFSymbol.currenciesTab
        case .settings:
            return SFSymbol.settingsTab
        }
    }
}

// MARK: - Tab Views

extension TabBarModel: View {

    var body: some View {
        switch self {
        case .dashboard:
            Text(name)
        case .cashFlow:
            Text(name)
        case .currencies:
            Text(name)
        case .settings:
            Text(name)
        }
    }
}

extension TabBarModel: Identifiable {
    var id: String { name }
}

extension TabBarModel: CaseIterable {}
