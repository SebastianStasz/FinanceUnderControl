//
//  FormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI

struct FormView<Content: View>: View {

    let content: Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .huge) { content }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.medium)
        }
        .background(Color.backgroundPrimary)
    }
}


// MARK: - Preview

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView { Text("Content") }
    }
}
