//
//  CashFlowCategoryListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import FinanceCoreData
import SwiftUI

final class CashFlowCategoryListVM: ObservableObject {
//    @Published private(set) var categories: FetchedResults<CashFlowCategoryEntity>

    @FetchRequest(entity: CashFlowCategoryEntity.entity(), sortDescriptors: []
    ) var categories: FetchedResults<CashFlowCategoryEntity>

    var sortDescriptors: [NSSortDescriptor] {
        [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor]
    }

    init(type: CashFlowCategoryType) {
//        categories = CashFlowCategoryEntity.fetchRequest(filteringBy: [.typeIs(type)], sortingBy: [.byName(.forward)]).wrappedValue
    }

    func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
//            managedObjectContext.delete(category)
        }
    }
}
