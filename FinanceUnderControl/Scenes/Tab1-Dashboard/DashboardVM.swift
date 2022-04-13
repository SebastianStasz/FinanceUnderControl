//
//  DashboardVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import FinanceCoreData
import Foundation

final class DashboardVM: ViewModel {

    init(controller: PersistenceController = AppVM.shared.controller) {
        super.init()
    }
}
