//
//  CashFlowCategoryFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 04/03/2022.
//

import SwiftUI
import FinanceCoreData

struct CashFlowCategoryFormView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryVM()
    let type: CashFlowCategoryType

    var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: .medium), count: 6)
    }

    var categoryModel: CashFlowCategoryModel {
        viewModel.categoryModel
    }

    var body: some View {
        FormView {
            categoryInfo
            colorSector
            iconSector
        }
        .horizontalButtonsScroll(title: "Create", primaryButton: .init("Create", enabled: categoryModel.name.notNil, action: createCashFlowCategory))
    }

    private func createCashFlowCategory() {
        guard let name = categoryModel.name else { return }
        let data = CashFlowCategoryData(name: name, icon: categoryModel.icon, color: categoryModel.color, type: type)
        CashFlowCategoryEntity.create(in: context, data: data)
        dismiss.callAsFunction()
    }
}


// MARK: - Preview

struct CashFlowCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryFormView(type: .expense)
    }
}
