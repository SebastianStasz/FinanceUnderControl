//
//  CashFlowCardView+FinanceCoreData.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import FinanceCoreData
import Shared

extension CashFlowCardView {
    init(_ cashFlow: CashFlowEntity) {
        self.init(title: cashFlow.name,
                  date: cashFlow.date,
                  money: cashFlow.money,
                  type: cashFlow.category.type,
                  icon: cashFlow.category.icon.rawValue,
                  iconColor: cashFlow.category.color.color
        )
    }
}
