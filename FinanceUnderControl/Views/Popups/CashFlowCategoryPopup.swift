//
//  CreateCashFlowCategoryView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI
import SSValidation
import SSUtils
import Shared
import FinanceCoreData

struct CashFlowCategoryPopup: View {
    @Environment(\.managedObjectContext) private var context

    @State private var input = Input<TextInputSettings>(settings: .init(minLength: 3, maxLength: 20))
    let type: CashFlowCategoryType

    var body: some View {
        BaseInputText(title: "Category name", input: $input)
            .asPopup(title: "Add category", isActionDisabled: input.value.isNil, action: createCashFlowCategory)
    }

    private func createCashFlowCategory() {
        guard let name = input.value else { return }
        let data = CashFlowCategoryData(name: name, icon: .banknoteFill, color: .red, type: type)
        CashFlowCategoryEntity.create(in: context, data: data)
    }

    init(for type: CashFlowCategoryType) {
        self.type = type
    }
}


// MARK: - Preview

struct CashFlowCategoryPopup_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryPopup(for: .income)
            .previewLayout(.sizeThatFits)
    }
}
