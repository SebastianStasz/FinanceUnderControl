//
//  ViewControllerProvider.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 16/05/2022.
//

import FinanceCoreData
import Foundation
import UIKit

struct ViewControllerProvider {

    static func exchangeRateList(for currency: CurrencyEntity) -> UIViewController {
        let viewModel = ExchangeRateListVM(currencyEntity: currency)
        let view = ExchangeRateListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.title = "\(String.cantor_base_currency): \(currency.code)"
        return viewController
    }

    static func cashFlowFilterVC(viewModel: CashFlowFilterVM) -> UIViewController {
        let view = CashFlowFilterView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.title = .cash_flow_filter_title

        viewModel.binding.dismiss
            .sink { [weak navigationController] in navigationController?.dismiss(animated: true) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }

    static func walletForm(for wallet: Wallet) -> UIViewController {
        let viewModel = WalletFormVM(wallet: wallet)
        let view = WalletFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        return viewController
    }
}
