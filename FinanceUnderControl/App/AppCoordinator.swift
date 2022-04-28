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
    private let navigationController: UINavigationController

    init(with window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        window.rootViewController = navigationController
        handleUserState()
    }

    private func handleUserState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let navigationController = self?.navigationController else { return }

            if let user = user, user.isEmailVerified, navigationController.viewControllers.notContains(TabBarView.self) {
                navigationController.viewControllers = []
                TabBarCoordinator(.push(on: navigationController)).start()
            } else if navigationController.viewControllers.notContains(LoginView.self) {
                navigationController.viewControllers = []
                AuthenticationCoordinator(.push(on: navigationController)).start()
            }
        }
    }
}
