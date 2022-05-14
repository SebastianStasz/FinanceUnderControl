//
//  CashFlowGroupingCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 08/05/2022.
//

import UIKit
import Shared

final class CashFlowGroupingCoordinator: Coordinator {

    enum Destination {
        case presentFormSelection
    }

    private let type: CashFlowType

    init(_ presentationStyle: PresentationStyle, type: CashFlowType) {
        self.type = type
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowGroupingListVM(for: type, coordinator: self)
        let view = CashFlowGroupingListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.title = type.namePlural
        let presentFormSelection = UIAction { _ in
            viewModel.binding.navigateTo.send(.presentFormSelection)
        }
        
        viewController.navigationItem.rightBarButtonItems = [.init(systemItem: .add, primaryAction: presentFormSelection)]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }
}

private extension CashFlowGroupingCoordinator {

    func navigate(to destination: Destination) {
        guard let navigationController = navigationController else { return }
        switch destination {
        case .presentFormSelection:
            presentFormSelection(on: navigationController)
        }
    }

    func presentFormSelection(on navigationController: UINavigationController) {
        let alert = UIAlertController(title: .settings_select_action, message: nil, preferredStyle: .actionSheet)
        alert.addAction(title: .settings_create_group, action: onSelf {
            CashFlowCategoryGroupFormCoordinator(.presentModally(on: navigationController), type: $0.type).start()
        })
        alert.addAction(title: .settings_create_category, action: onSelf {
            CashFlowCategoryFormCoordinator(.presentModally(on: navigationController), formType: .new($0.type)).start()
        })
        alert.addCancelAction()
        navigationController.present(alert, animated: true)
    }
}
