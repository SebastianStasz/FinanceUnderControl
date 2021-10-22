//
//  FinanceUnderControlApp.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import SwiftUI

@main
struct FinanceUnderControlApp: App {

    @State private var tabBarVM = TabBarVM()

    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: tabBarVM)
        }
    }
}
