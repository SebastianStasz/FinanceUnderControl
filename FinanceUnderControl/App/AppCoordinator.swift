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
            let coordinator: RootCoordinator = user != nil ? TabBarCoordinator() : AuthenticationCoordinator()
            self?.window.rootViewController = coordinator.start()
        }
    }
}
