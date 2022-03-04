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
    private let sectors: [String: [T]]
    private let rowView: (T) -> RowView
    private let onDelete: ((IndexSet) -> Void)?

    private var isWithoutSectors: Bool {
        sectors.count == 1 && sectors.first?.key == ""
    }

    var body: some View {
        List {
            Group {
                if isWithoutSectors { elementsForSector("") }
                else { listWithSectors }
            }
            .listRowBackground(Color.backgroundPrimary)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal, .large)
        }
        .listStyle(.grouped)
        .background(Color.backgroundPrimary)
        .environment(\.defaultMinListRowHeight, 1)
        .environment(\.defaultMinListHeaderHeight, 1)
        .emptyState(isEmpty: sectors.isEmpty, message: emptyMessage)
        .navigationTitle(title)
    }

    private var listWithSectors: some View {
        ForEach(Array(sectors.keys), id: \.self) { sector in
            Section(sectorHeader: sector) { elementsForSector(sector) }
        }
    }

    @ViewBuilder
    private func elementsForSector(_ sector: String) -> some View {
        if let elements = sectors[sector] {
            ForEach(elements) { rowView($0) ;separator }
                .onDelete(perform: onDelete)
        }
    }

    private var separator: some View {
        Color.backgroundPrimary
            .frame(height: .small)
            .deleteDisabled(true)
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
        self.sectors = ["": elements]
        self.rowView = rowView
        self.onDelete = onDelete
        UITableView.appearance().sectionFooterHeight = .xxlarge
    }

    init(_ title: String,
         emptyMessage: String? = nil,
         sectors: [String: [T]],
         onDelete: ((IndexSet) -> Void)? = nil,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.title = title
        self.emptyMessage = emptyMessage
        self.sectors = sectors
        self.rowView = rowView
        self.onDelete = onDelete
        UITableView.appearance().sectionFooterHeight = .xxlarge
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
