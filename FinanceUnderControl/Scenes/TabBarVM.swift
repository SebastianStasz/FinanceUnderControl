//
//  TabBarVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Foundation

final class TabBarVM: ObservableObject {
    typealias Tab = TabBarModel
    var availableTabs: [Tab] { Tab.allCases }

    @Published var selectedTab: Tab = .dashboard
}

// MARK: - Navigator

extension TabBarVM {

    enum Destination {
        case tab(Tab)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .tab(let tab):
            selectedTab = tab
        }
    }
}
