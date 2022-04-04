//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import FinanceCoreData
import SwiftUI
import SSUtils

struct BaseList<T: Identifiable, RowView: View>: View where T: Equatable {

    private let title: String
    private let emptyMessage: String?
    private let sectors: [ListSector<T>]
    private let rowView: (T) -> RowView

    var body: some View {
        List {
            Group {
                if isListWithoutSectors {
                    listForSector(sectors.first!)
                } else {
                    ForEach(sectors) { sector in
                        Section(sector.header, shouldBePresented: sector.shouldBePresented) {
                            listForSector(sector)
                        }
                    }
                }
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

    private func listForSector(_ sector: ListSector<T>) -> some View {
        ForEach(sector.elements) { rowView($0) ; separator }
    }

    private var separator: some View {
        Color.backgroundPrimary
            .frame(height: .small)
            .deleteDisabled(true)
    }

    private var isListWithoutSectors: Bool {
        sectors.count == 1 && sectors.first?.title == ListSector<T>.unvisibleSectorTitle
    }

    init(
        _ title: String,
        emptyMessage: String? = nil,
        sectors: [ListSector<T>],
        @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.title = title
        self.emptyMessage = emptyMessage
        self.sectors = sectors
        self.rowView = rowView
        UITableView.appearance().sectionFooterHeight = .small
        UITableView.appearance().sectionHeaderTopPadding = .large
    }
}

// MARK: - Initializers

extension BaseList {

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: [T],
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(title, emptyMessage: emptyMessage, sectors: ListSector.unvisibleSector(elements), rowView: rowView)
    }

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: FetchedResults<T>,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        self.init(title, emptyMessage: emptyMessage, elements: elements.map { $0 }, rowView: rowView)
    }

    init<I>(_ title: String,
            emptyMessage: String? = nil,
            sectorIdMapper: (I) -> String,
            sectors: SectionedFetchResults<I, T>,
            @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        let sectors = sectors.map { ListSector(sectorIdMapper($0.id), elements: $0.map { $0 }) }
        self.init(title, emptyMessage: emptyMessage, sectors: sectors, rowView: rowView)
    }
}
