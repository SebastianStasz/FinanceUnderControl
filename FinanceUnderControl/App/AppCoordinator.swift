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
        let authenticationCoordinator = AuthenticationCoordinator()
        window.rootViewController = authenticationCoordinator.rootViewController
        childCoordinators.append(authenticationCoordinator)
    }
}
