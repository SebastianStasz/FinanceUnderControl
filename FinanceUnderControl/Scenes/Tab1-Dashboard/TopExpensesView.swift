//
//  TopExpensesView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/06/2022.
//

import SwiftUI
import Shared

struct TopExpensesView: View {
    @Environment(\.dismiss) private var dismiss

    let viewData: HorizontalBarVD

    var body: some View {
        NavigationView {
            ScrollView {
                HorizontalBarView(viewData: viewData)
            }
            .navigationTitle("This month top expenses")
            .navigationBarTitleDisplayMode(.inline)
            .closeButton(action: dismiss.callAsFunction)
        }
    }
}

// MARK: - Preview

struct TopExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        TopExpensesView(viewData: .sample)
        TopExpensesView(viewData: .sample).darkScheme()
    }
}
