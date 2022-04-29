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
    private var rootViewController: UIViewController!
    private let window: UIWindow

    init(with window: UIWindow) {
        self.window = window
        handleUserState()
    }

    private func handleUserState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }

            if user != nil {
                self.rootViewController = TabBarCoordinator().start()
            } else {
                AuthenticationCoordinator(.presentFullScreen(on: self.rootViewController)).start()
            }
            self.window.rootViewController = self.rootViewController
        }
    }
}
