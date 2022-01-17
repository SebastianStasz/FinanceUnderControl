//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import SwiftUI

struct CashFlowFilterView: View {

    @Binding var cashFlowSelection: CashFlowSelection

    var body: some View {
        Form {
            SegmentedPicker("Cash flow type", selection: $cashFlowSelection, elements: CashFlowSelection.allCases)
        }
    }
}


// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFilterView(cashFlowSelection: .constant(.all))
    }
}
