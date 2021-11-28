//
//  CantorVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Combine
import FinanceCoreData
import Foundation
import SwiftUI

final class CantorVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []

    @Published var primaryCurrency: CurrencyEntity?
    @Published var secondaryCurrency: CurrencyEntity?
    @Published var currencyListVM = CurrencyListVM()
}
