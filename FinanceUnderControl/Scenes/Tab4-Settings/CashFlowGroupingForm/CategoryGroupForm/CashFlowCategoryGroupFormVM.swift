//
//  CashFlowCategoryGroupFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import FinanceCoreData
import Foundation

final class CashFlowCategoryGroupFormVM: CashFlowGroupingFormVM<CashFlowCategoryGroupEntity> {

    @Published private(set) var otherCategories: [CashFlowCategoryEntity] = []

    override func onAppear(formType: FormType) {
        super.onAppear(formType: formType)
        if let name = formModel.name {
            otherCategories = CashFlowCategoryEntity.getAll(from: context, filters: .type(formModel.type!), .groupNameIsNot(name))
        } else {
            otherCategories = CashFlowCategoryEntity.getAll(from: context, filters: .type(formModel.type!))
        }
        sortOtherCategories()
    }

    func checkCategory(_ category: CashFlowCategoryEntity) {
        otherCategories.remove(element: category)
        formModel.categories.append(category)
        formModel.categories.sort(by: {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        })
    }

    func uncheckCategory(_ category: CashFlowCategoryEntity) {
        formModel.categories.remove(element: category)
        otherCategories.append(category)
        sortOtherCategories()
    }

    private func sortOtherCategories() {
        otherCategories.sort(by: { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending })
    }
}

extension Array where Element: Equatable {

    @discardableResult
    mutating func remove(element: Element) -> Element? {
        guard let index = self.firstIndex(of: element) else { return nil }
        return self.remove(at: index)
    }
}
