//
//  FormView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import SSUtils

public struct FormView<Content: View>: View {

    private let content: Content

    public init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .xxlarge) { content }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, .large)
        }
        .background(Color.backgroundPrimary)
    }
}

// MARK: - Preview

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormView { Text("Content") }
            FormView { Text("Content") }.darkScheme()
        }
    }
}
