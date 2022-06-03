//
//  DesignSystemCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/06/2022.
//

import Shared
import SwiftUI

final class DesignSystemCoordinator: CoordinatorProtocol {

    enum Destination {
        case text
        case color
        case sfSymbol
        case spacing
        case cornerRadius
        case button
        case toggle
        case picker
        case textField
        case sector
        case circleView
    }

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = DesignSystemVM(coordinator: self)
        let view = DesignSystemView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        navigationController.push(viewController)
    }

    private func navigate(to destination: Destination) {
        let vc: UIViewController
        switch destination {
        case .text:
            vc = UIHostingController(rootView: TextDSView())
        case .color:
            vc = UIHostingController(rootView: ColorDSView())
        case .sfSymbol:
            vc = UIHostingController(rootView: SFSymbolDSView())
        case.spacing:
            vc = UIHostingController(rootView: SpacingDSView())
        case .cornerRadius:
            vc = UIHostingController(rootView: CornerRadiusDSView())
        case .button:
            vc = UIHostingController(rootView: ButtonDSView())
        case .toggle:
            vc = UIHostingController(rootView: ToggleDSView())
        case .picker:
            vc = UIHostingController(rootView: PickerDSView())
        case .textField:
            vc = UIHostingController(rootView: TextFieldDSView())
        case .sector:
            vc = UIHostingController(rootView: SectorDSView())
        case .circleView:
            vc = UIHostingController(rootView: CircleViewDSView())
        }
        navigationController.push(vc)
    }
}
