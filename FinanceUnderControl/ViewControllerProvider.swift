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
}
