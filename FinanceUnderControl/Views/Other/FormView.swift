//
//  FormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import SSUtils
import Shared

struct FormView<Content: View>: View {

    let content: Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: .xxlarge) { content }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, .large)
        }
        .background(Color.backgroundPrimary)
        .toolbar { toolbarContent }
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.keyboard {
            Button(symbol: .dismissKeyboard, action: hideKeyboard)
                .infiniteWidth(alignment: .trailing)
        }
    }
}

// MARK: - Preview

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView { Text("Content") }
    }
}
