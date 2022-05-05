//
//  CashFlowCardView+FinanceCoreData.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import FinanceCoreData
import Shared

extension CashFlowCardView {
    init(_ cashFlow: CashFlowDocument) {
        self.init(title: cashFlow.name,
                  date: cashFlow.date,
                  money: cashFlow.money,
                  type: .expense,
                  icon: "house",
                  iconColor: .indigo
        )
    }
}
