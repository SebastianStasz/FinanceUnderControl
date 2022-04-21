//
//  FinanceUnderControlApp.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import SwiftUI

@main
struct FinanceUnderControlApp: App {
    @Environment(\.scenePhase) private var scenePhase

    private let viewModel = AppVM.shared

    var body: some Scene {
        WindowGroup {
            LoginView()

//            TabBarView()
//                .environment(\.managedObjectContext, viewModel.context)
//                .task { await AppVM.shared.setupCurrencies() }
//                .onChange(of: scenePhase) { viewModel.didChangeScenePhase(to: $0) }
        }
    }
}
