//
//  AuthenticationCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import SwiftUI

final class AuthenticationCoordinator: Coordinator {

    var viewController = UIViewController()

    func start() {
        viewController = UIHostingController(rootView: LoginView())
    }
}

