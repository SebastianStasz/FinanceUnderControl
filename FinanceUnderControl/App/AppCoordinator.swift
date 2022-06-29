//
//  AppCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Combine
import FirebaseAuth
import SwiftUI

final class AppCoordinator {

    private var cancellables: Set<AnyCancellable> = []
    private let window: UIWindow

    init(with window: UIWindow) {
        self.window = window
        window.overrideUserInterfaceStyle = PersistentStorage.appTheme.userInterfaceStyle

        AppVM.shared.binding.didChangeAppTheme
            .map { PersistentStorage.appTheme }
            .sink { window.overrideUserInterfaceStyle = $0.userInterfaceStyle }
            .store(in: &cancellables)

        AppVM.shared.output.isUserLoggedIn
            .sink { isLoggedIn in
                let coordinator: RootCoordinator = isLoggedIn ? TabBarCoordinator() : AuthenticationCoordinator()
                window.rootViewController = coordinator.start()
            }
            .store(in: &cancellables)
    }
}
