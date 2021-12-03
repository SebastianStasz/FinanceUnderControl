//
//  BaseListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import SwiftUI

struct BaseListView<T: Identifiable, Content: View>: View {

    private let items: [T]
    private let emptyMessage: String?
    private let rowView: (T) -> Content

    init(items:  [T],
         emptyMessage: String? = nil,
         @ViewBuilder rowView: @escaping (T) -> Content
    ) {
        self.items = items
        self.emptyMessage = emptyMessage
        self.rowView = rowView
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    rowView(item)
                    Divider()
                }
                .padding(.horizontal, .medium)
            }
        }
        .emptyState(isEmpty: items.isEmpty, message: emptyMessage)
    }
}
