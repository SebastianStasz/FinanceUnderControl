//
//  Pickerable+FinanceCoreData.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/04/2022.
//

import FinanceCoreData
import Shared

extension CurrencyEntity: Pickerable {
    public var valueName: String { code }
}

extension CashFlowCategoryEntity: Pickerable {
    public var valueName: String { name }
}
