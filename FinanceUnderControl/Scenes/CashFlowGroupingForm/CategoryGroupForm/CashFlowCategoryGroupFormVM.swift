//
//  CashFlowCategoryGroupFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import FinanceCoreData
import Foundation

final class CashFlowCategoryGroupFormVM: CashFlowGroupingFormVM<CashFlowCategoryGroupEntity> {

    @Published private(set) var includedCategories: [CashFlowCategoryEntity] = []
    @Published private(set) var otherCategories: [CashFlowCategoryEntity] = []

    override func onAppear(formType: FormType) {
        super.onAppear(formType: formType)
        includedCategories = formType.formModel.categories
        if let name = formModel.name {
            otherCategories = CashFlowCategoryEntity.getAll(from: context, filteringBy: [.group(.isNotWithName(name))])
        } else {
            otherCategories = CashFlowCategoryEntity.getAll(from: context)
        }
    }

    func checkCategory(_ category: CashFlowCategoryEntity) {
        otherCategories.remove(element: category)
        includedCategories.append(category)
        includedCategories.sort(by: { $0.name < $1.name })
    }

    func uncheckCategory(_ category: CashFlowCategoryEntity) {
        includedCategories.remove(element: category)
        otherCategories.append(category)
        otherCategories.sort(by: { $0.name < $1.name })
    }
}

extension Array where Element: Equatable {

    @discardableResult
    mutating func remove(element: Element) -> Element? {
        guard let index = self.firstIndex(of: element) else { return nil }
        return self.remove(at: index)
    }
}
