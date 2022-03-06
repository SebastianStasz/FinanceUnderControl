//
//  CashFlowCategoryVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Foundation
import SSValidation

final class CashFlowCategoryVM: ObservableObject {
    @Published var nameInput = Input<TextInputSettings>(settings: .init(minLength: 3, maxLength: 20))
    @Published var model = CashFlowCategoryModel()
}
