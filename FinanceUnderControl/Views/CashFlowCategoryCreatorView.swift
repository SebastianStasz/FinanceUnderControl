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

struct CashFlowCategoryCreatorView: View {
    @Environment(\.managedObjectContext) private var context

    @State private var input = Input<TextInputSettings>(settings: .init(minLength: 3, maxLength: 20))
    @Binding var isPresented: Bool
    let type: CashFlowCategoryType

    var body: some View {
        BaseTextField<TextInputVM>(title: "Category name", input: $input)
            .textFieldStyle(.roundedBorder)
            .asPopup(title: "Add category", isPresented: $isPresented, isActionDisabled: input.value.isNil, action: createCashFlowCategory)
    }

    private func createCashFlowCategory() {
        guard let name = input.value else { return }
        let data = CashFlowCategoryData(name: name, type: type)
        CashFlowCategoryEntity.create(in: context, data: data)
    }

    init(for type: CashFlowCategoryType, isPresented: Binding<Bool>) {
        self.type = type
        self._isPresented = isPresented
    }
}


// MARK: - Preview

struct CreateCashFlowCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryCreatorView(for: .income, isPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
