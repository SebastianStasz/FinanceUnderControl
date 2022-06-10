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
        case presentFormSelection(CashFlowType)
        case presentEditGroupForm(CashFlowCategoryGroup)
        case presentEditCategoryForm(CashFlowCategory)
        case presentCategoryCanNotBeDeleted(CashFlowCategory)
    }

    private let navigationController = UINavigationController()
    @State var isEditMode = false

    func start() -> UIViewController {
        let viewModel = CashFlowGroupingListVM(coordinator: self)
        let view = CashFlowGroupingListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }
}

private extension CashFlowGroupingCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case let .presentFormSelection(type):
            presentFormSelection(for: type)
        case let .presentEditGroupForm(group):
            presentGroupForm(.edit(group))
        case let .presentEditCategoryForm(category):
            presentCategoryForm(.edit(category))
        case let .presentCategoryCanNotBeDeleted(category):
            presentCategoryCanNotBeDeleted(category)
        }
    }

    func presentFormSelection(for type: CashFlowType) {
        let alert = UIAlertController.actionSheet(title: .settings_select_action)
        alert.addAction(title: .settings_create_group, action: onSelf { $0.presentGroupForm(.new(type)) })
        alert.addAction(title: .settings_create_category, action: onSelf { $0.presentCategoryForm(.new(type)) })
        alert.addCancelAction()
        navigationController.present(alert, animated: true)
    }

    func presentGroupForm(_ formType: CashFlowFormType<CashFlowCategoryGroup>) {
        CashFlowCategoryGroupFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }

    func presentCategoryForm(_ formType: CashFlowFormType<CashFlowCategory>) {
        CashFlowCategoryFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }

    func presentCategoryCanNotBeDeleted(_ category: CashFlowCategory) {
        let alert = UIAlertController(title: "Can not delete category", message: "Category \"\(category.name)\" is used by some cash flows. You can not delete it.", preferredStyle: .alert)
        alert.addOkAction()
        navigationController.present(alert, animated: true)
    }
}
