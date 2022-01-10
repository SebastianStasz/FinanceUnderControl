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

final class CreateCashFlowCategoryVM: ObservableObject {
    @Published var categoryNameInput = Input<TextInputSettings>(settings: .init(minLength: 3, maxLength: 20))
}

struct CreateCashFlowCategoryView: View {

    @StateObject private var viewModel = CreateCashFlowCategoryVM()
    @Binding var isPresented: Bool

    var body: some View {
        BaseTextField<TextInputVM>(title: "Category name", input: $viewModel.categoryNameInput)
            .textFieldStyle(.roundedBorder)
            .asPopup(title: "Add category", isPresented: $isPresented)
    }

    private func closePopup() {
        isPresented = false
    }
}


// MARK: - Preview

struct CreateCashFlowCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCashFlowCategoryView(isPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
