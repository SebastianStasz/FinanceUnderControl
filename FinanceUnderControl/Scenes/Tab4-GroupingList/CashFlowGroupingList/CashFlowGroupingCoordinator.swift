//
//  CashFlowGroupingCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 08/05/2022.
//

import UIKit
import Shared
import SwiftUI

final class CashFlowGroupingCoordinator: RootCoordinator, ObservableObject {

    enum Destination {
        case presentFormSelection
        case presentEditGroupForm(CashFlowCategoryGroup)
        case presentEditCategoryForm(CashFlowCategory)
    }

    private let navigationController = UINavigationController()
    private let type: CashFlowType
    @State var isEditMode = false

    init(type: CashFlowType) {
        self.type = type
    }

    func start() -> UIViewController {
        let viewModel = CashFlowGroupingListVM(for: type)
        let view = CashFlowGroupingListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        })
        viewController.title = type.namePlural
        let presentFormSelection = UIAction { _ in
            viewModel.binding.navigateTo.send(.presentFormSelection)
        }
        
        viewController.navigationItem.rightBarButtonItems = [
            .init(systemItem: .add, primaryAction: presentFormSelection),
        ]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }
}

private extension CashFlowGroupingCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case .presentFormSelection:
            presentFormSelection()
        case let .presentEditGroupForm(group):
            presentGroupForm(.edit(group))
        case let .presentEditCategoryForm(category):
            presentCategoryForm(.edit(category))
        }
    }

    func presentFormSelection() {
        let alert = UIAlertController.actionSheet(title: .settings_select_action)
        alert.addAction(title: .settings_create_group, action: onSelf { $0.presentGroupForm(.new($0.type)) })
        alert.addAction(title: .settings_create_category, action: onSelf { $0.presentCategoryForm(.new($0.type)) })
        alert.addCancelAction()
        navigationController.present(alert, animated: true)
    }

    func presentGroupForm(_ formType: CashFlowFormType<CashFlowCategoryGroup>) {
        CashFlowCategoryGroupFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }

    func presentCategoryForm(_ formType: CashFlowFormType<CashFlowCategory>) {
        CashFlowCategoryFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }
}
