//
//  CashFlowCategoryVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Combine
import Foundation
import FinanceCoreData
import SSValidation

final class CashFlowCategoryVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []

    @Published var nameInput = Input<TextInputSettings>(settings: .init(minLength: 3, maxLength: 20))
    @Published var categoryModel = CashFlowCategoryModel()
    private(set) var categoryData: CashFlowCategoryData?

    init() {
        $nameInput
            .sink { [weak self] nameInput in
                self?.categoryModel.name = nameInput.value
            }
            .store(in: &cancellables)
    }
}
