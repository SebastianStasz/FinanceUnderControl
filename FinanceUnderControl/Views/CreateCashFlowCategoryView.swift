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
        VStack(spacing: .medium) {
            BaseTextField<TextInputVM>(title: "Category name", input: $viewModel.categoryNameInput)

            HStack(spacing: .medium) {
                Button("Cancel", action: closePopup)
                    .infiniteWidth()

                Button("Create", action: ())
                    .infiniteWidth()
            }
        }
        .frame(width: UIScreen.screenWidth - 2 * Spacing.medium.rawValue)
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
