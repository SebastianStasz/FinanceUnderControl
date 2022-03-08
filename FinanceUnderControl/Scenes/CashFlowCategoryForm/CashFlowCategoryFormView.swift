//
//  CashFlowCategoryFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 04/03/2022.
//

import Combine
import SwiftUI
import FinanceCoreData

struct CashFlowCategoryFormView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryVM()
    let model: CashFlowCategoryModel

    var elementsSpacing: CGFloat { .micro }

    var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: elementsSpacing), count: 6)
    }

    var body: some View {
        FormView {
            categoryInfo
            colorSector
            iconSector
        }
        .horizontalButtonsScroll(title: "Create", primaryButton: .init("Create", enabled: viewModel.isFormValid, action: createCashFlowCategory))
        .onAppear { viewModel.categoryModel = model}
        .onReceive(viewModel.output.dismissView) { dismiss.callAsFunction() }
    }

    private func createCashFlowCategory() {
        viewModel.input.didTapCreate.send()
    }
}


// MARK: - Preview

struct CashFlowCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryFormView(model: .newForType(.expense))
    }
}
