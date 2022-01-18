//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import FinanceCoreData
import SwiftUI

struct BaseList<T: Identifiable, RowView: View>: View {

    let title: String
    let emptyMessage: String?
    let elements: [T]
    let rowView: (T) -> RowView
    let onDelete: ((IndexSet) -> Void)?

    var body: some View {
        List {
            ForEach(elements, content: rowView)
                .onDelete(perform: onDelete)
        }
        .emptyState(isEmpty: elements.isEmpty, message: emptyMessage)
        .navigationTitle(title)
    }

    // MARK: - Initializers

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: [T],
         @ViewBuilder rowView: @escaping (T) -> RowView,
         onDelete: ((IndexSet) -> Void)? = nil
    ) {
        self.title = title
        self.emptyMessage = emptyMessage
        self.elements = elements
        self.rowView = rowView
        self.onDelete = onDelete
    }

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: FetchedResults<T>,
         @ViewBuilder rowView: @escaping (T) -> RowView,
         onDelete: ((IndexSet) -> Void)? = nil
    ) where T: Entity {
        self.init(title, emptyMessage: emptyMessage, elements: elements.map{$0}, rowView: rowView, onDelete: onDelete)
    }
}
