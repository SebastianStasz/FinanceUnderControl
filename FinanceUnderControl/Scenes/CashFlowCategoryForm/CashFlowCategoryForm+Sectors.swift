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
            CircleView(color: categoryModel.color.color, icon: categoryModel.icon, size: 95)
            LabeledInputText("Name", input: $viewModel.categoryModel.nameInput, style: .secondary)
        }
        .card()
    }

    var colorSector: some View {
        Sector("Color", style: .card) {
            LazyVGrid(columns: grid, alignment: .center, spacing: elementsSpacing) {
                ForEach(CashFlowCategoryColor.allCases) { color in
                    CircleView(color: color.color)
                        .selection($viewModel.categoryModel.color, element: color)
                }
            }
        }
    }

    var iconSector: some View {
        Sector("Icon", style: .card) {
            LazyVGrid(columns: grid, alignment: .center, spacing: elementsSpacing) {
                ForEach(CashFlowCategoryIcon.allCases) { (icon: CashFlowCategoryIcon) in
                    CircleView(color: .basicSecondary, icon: icon)
                        .selection($viewModel.categoryModel.icon, element: icon)
                }
            }
        }
    }

    private var categoryModel: CashFlowCategoryModel {
        viewModel.categoryModel
    }
}
