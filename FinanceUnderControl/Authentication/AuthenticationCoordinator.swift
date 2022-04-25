//
//  AuthenticationCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Combine
import SwiftUI

final class SwiftUIVC<Content: View>: UIHostingController<Content> {
    private let viewModel: ViewModel2
    var cancellables: Set<AnyCancellable> = []

    init(viewModel: ViewModel2, view: Content) {
        self.viewModel = viewModel
        super.init(rootView: view)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AuthenticationCoordinator: Coordinator {

    override func initializeView() -> UIViewController {
        let viewModel = LoginVM(coordinator: self)
        let viewController = SwiftUIVC(viewModel: viewModel, view: LoginView(viewModel: viewModel))

        viewModel.viewBinding.didTapSignUp
            .sink { [weak self] in self?.presentRegisterView() }
            .store(in: &viewController.cancellables)

        return viewController
    }

    private func presentRegisterView() {
        guard let navigationController = navigationController else { return }
        RegisterCoordinator(.presentFullScreen(on: navigationController)).start()
    }
}

extension UIViewController {
    func presentFullScreen(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
