//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import FinanceCoreData
import SwiftUI

struct BaseList<T: Identifiable, RowView: View>: View where T: Equatable {

    private let title: String
    private let emptyMessage: String?
    private let elements: [T]
    private let rowView: (T) -> RowView
    private let onDelete: ((IndexSet) -> Void)?

    var body: some View {
        List {
            ForEach(elements) {
                rowView($0)
                separator(for: $0)
            }
            .onDelete(perform: onDelete)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.backgroundPrimary)
            .padding(.horizontal, .medium)
        }
        .listStyle(.plain)
        .navigationTitle(title)
        .background(Color.backgroundPrimary)
        .environment(\.defaultMinListRowHeight, 1)
        .emptyState(isEmpty: elements.isEmpty, message: emptyMessage)
    }

    private func separator(for element: T) -> some View {
        Color.backgroundPrimary
            .frame(height: .small)
            .deleteDisabled(true)
            .displayIf(element != elements.last)
    }

    // MARK: - Initializers

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: [T],
         onDelete: ((IndexSet) -> Void)? = nil,
         @ViewBuilder rowView: @escaping (T) -> RowView
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
         onDelete: ((IndexSet) -> Void)? = nil,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        self.init(title, emptyMessage: emptyMessage, elements: elements.map{$0}, onDelete: onDelete, rowView: rowView)
    }
}
