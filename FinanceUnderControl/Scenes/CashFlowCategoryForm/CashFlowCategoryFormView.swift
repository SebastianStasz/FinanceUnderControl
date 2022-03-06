//
//  CashFlowCategoryFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 04/03/2022.
//

import SwiftUI
import FinanceCoreData

struct CashFlowCategoryFormView: View {

    @StateObject private var viewModel = CashFlowCategoryVM()
    let type: CashFlowCategoryType

    private var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: .medium), count: 6)
    }

    var body: some View {
        FormView {
            VStack(alignment: .center, spacing: .medium) {
                CircleView(color: viewModel.model.color.color, icon: viewModel.model.icon, size: 100)
                LabeledInputText("Name", input: $viewModel.nameInput, style: .secondary)
            }
            .card()

            Sector("Color", style: .card) {
                LazyVGrid(columns: grid, alignment: .center, spacing: .medium) {
                    ForEach(CashFlowCategoryColor.allCases) { color in
                        CircleView(color: color.color)
                            .selection($viewModel.model.color, element: color)
                    }
                }
            }

            Sector("Icon", style: .card) {
                LazyVGrid(columns: grid, alignment: .center, spacing: .medium) {
                    ForEach(CashFlowCategoryIcon.allCases) { (icon: CashFlowCategoryIcon) in
                        CircleView(color: .gray, icon: icon)
                            .selection($viewModel.model.icon, element: icon)
                    }
                }
            }
        }
        .asSheet(title: "Create")
    }
}


// MARK: - Preview

struct CashFlowCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryFormView(type: .expense)
    }
}
