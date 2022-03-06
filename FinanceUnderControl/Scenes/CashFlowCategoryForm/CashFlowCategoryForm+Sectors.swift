//
//  CashFlowCategoryForm+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import FinanceCoreData
import SwiftUI

extension CashFlowCategoryFormView {

    var categoryInfo: some View {
        VStack(alignment: .center, spacing: .medium) {
            CircleView(color: categoryModel.color.color, icon: categoryModel.icon, size: 100)
            LabeledInputText("Name", input: $viewModel.nameInput, style: .secondary)
        }
        .card()
    }

    var colorSector: some View {
        Sector("Color", style: .card) {
            LazyVGrid(columns: grid, alignment: .center, spacing: .medium) {
                ForEach(CashFlowCategoryColor.allCases) { color in
                    CircleView(color: color.color)
                        .selection($viewModel.categoryModel.color, element: color)
                }
            }
        }
    }

    var iconSector: some View {
        Sector("Icon", style: .card) {
            LazyVGrid(columns: grid, alignment: .center, spacing: .medium) {
                ForEach(CashFlowCategoryIcon.allCases) { (icon: CashFlowCategoryIcon) in
                    CircleView(color: .gray, icon: icon)
                        .selection($viewModel.categoryModel.icon, element: icon)
                }
            }
        }
    }
}
