//
//  AppCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import SwiftUI

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []

    init(with window: UIWindow) {
        self.window = window
    }

    func start() {
        let authenticationCoordinator = AuthenticationCoordinator()
        authenticationCoordinator.start()
        window.rootViewController = authenticationCoordinator.viewController
        childCoordinators.append(authenticationCoordinator)
    }
}
