//
//  ExpensesByCategoryView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/06/2022.
//

import SwiftUI
import Shared

struct ExpensesByCategoryView: View {
    @Environment(\.dismiss) private var dismiss

    let viewData: HorizontalBarVD

    var body: some View {
            ScrollView {
                HorizontalBarView(viewData: viewData)
            }
            .closeButton(action: dismiss.callAsFunction)
            .embedInNavigationView(title: .expenses_by_category_title, displayMode: .inline)
    }
}

// MARK: - Preview

struct ExpensesByCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesByCategoryView(viewData: .sample)
        ExpensesByCategoryView(viewData: .sample).darkScheme()
    }
}
