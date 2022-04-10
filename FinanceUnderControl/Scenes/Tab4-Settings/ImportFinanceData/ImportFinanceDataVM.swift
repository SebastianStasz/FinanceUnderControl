//
//  ImportFinanceDataVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/04/2022.
//

import Foundation
import SSUtils

final class ImportFinanceDataVM: ViewModel {

    struct Input {
        let didTapExport = DriverSubject<Void>()
    }

    let input = Input()
}
