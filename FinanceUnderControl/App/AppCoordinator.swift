//
//  AppCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import SwiftUI

final class AppCoordinator {

    private let window: UIWindow

    init(with window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        AuthenticationCoordinator(.push(on: navigationController)).start()
    }
}
