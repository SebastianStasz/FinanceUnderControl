//
//  CashFlowPopup.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 11/01/2022.
//

import SwiftUI
import SSValidation
import FinanceCoreData

struct CashFlowPopup: View {

    @State private var valueInput = Input<NumberInputSettings>(settings: .init(minValue: 0.01, keyboardType: .numbersAndPunctuation))
    @Binding var isPresented: Bool
    let type: CashFlowCategoryType

    var body: some View {
        VStack {
            BaseTextField<NumberInputVM>(title: "Value", input: $valueInput)
        }
        .asPopup(title: type.name, isPresented: $isPresented, isActionDisabled: valueInput.value.isNil, action: createCashFlow)
    }

    private func createCashFlow() {

    }

    init(for type: CashFlowCategoryType, isPresented: Binding<Bool>) {
        self.type = type
        self._isPresented = isPresented
    }
}


// MARK: - Preview

struct CashFlowPopup_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowPopup(for: .income, isPresented: .constant(true))
    }
}
