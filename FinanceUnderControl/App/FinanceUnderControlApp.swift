//
//  FinanceUnderControlApp.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import SwiftUI

@main
struct FinanceUnderControlApp: App {

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, AppVM.shared.context)
        }
    }
}
