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
        handleUserState()
    }

    private func handleUserState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            let coordinator: RootCoordinator = user != nil ? TabBarCoordinator() : AuthenticationCoordinator()
            let viewController = coordinator.start()
            self.window.rootViewController = viewController
        }
    }
}
