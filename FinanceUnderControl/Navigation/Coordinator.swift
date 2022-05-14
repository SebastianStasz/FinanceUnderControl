//
//  Coordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/04/2022.
//

import UIKit
import SSUtils

protocol CoordinatorProtocol: BaseActions {}

class Coordinator: CoordinatorProtocol {
    private let presentationStyle: PresentationStyle
    weak var navigationController: UINavigationController?

    init(_ presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }

    func start() {
        switch presentationStyle {
        case let .push(navigationController):
            push(on: navigationController)
        case let .presentModally(on: viewController):
            guard let vc = viewController else { return}
            presentModally(on: vc)
        case let .presentFullScreen(viewController):
            presentFullScreen(on: viewController)
        }
    }

    func initializeView() -> UIViewController {
        UIViewController()
    }

    func dismiss(animated: Bool = true) {
        navigationController?.dismiss(animated: animated)
    }

    private func push(on navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.pushViewController(initializeView(), animated: true)
    }

    private func presentModally(on viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: initializeView())
        self.navigationController = navigationController
        viewController.present(navigationController, animated: true)
    }

    private func presentFullScreen(on viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: initializeView())
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController = navigationController
        viewController.present(navigationController, animated: true)
    }
}

final class PreviewCoordinator: Coordinator {
    init() { super.init(.push(on: UINavigationController())) }
}
