//
//  CashFlowGroupingCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 08/05/2022.
//

import UIKit
import Shared

final class CashFlowGroupingCoordinator: Coordinator {

    private let type: CashFlowType

    init(_ presentationStyle: PresentationStyle, type: CashFlowType) {
        self.type = type
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowGroupingListVM(for: type, coordinator: self)
        let view = CashFlowGroupingListView(viewModel: viewModel)
        return SwiftUIVC(viewModel: viewModel, view: view)
    }
}
