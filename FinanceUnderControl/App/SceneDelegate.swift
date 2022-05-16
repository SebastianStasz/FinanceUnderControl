//
//  SceneDelegate.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Firebase
import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            appCoordinator = AppCoordinator(with: window)
            window.makeKeyAndVisible()
        }
    }
}
