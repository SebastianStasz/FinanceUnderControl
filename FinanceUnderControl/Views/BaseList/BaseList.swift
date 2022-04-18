//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import FinanceCoreData
import Shared
import SwiftUI
import SSUtils

struct BaseList<T: Identifiable, RowView: View>: View where T: Equatable {

    private let title: String
    private let emptyStateVD: EmptyStateVD
    private let sectors: [ListSector<T>]
    private let rowView: (T) -> RowView
    var deleteElement: ((T) -> Void)?

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
        .emptyState(isEmpty: sectors.isEmpty, viewData: emptyStateVD)
        .navigationTitle(title)
    }

    private func listForSector(_ sector: ListSector<T>) -> some View {
        ForEach(sector.elements) { rowView($0) ; separator }
            .onDelete { tryToDeleteElement(in: sector, at: $0) }
    }

    private func tryToDeleteElement(in sector: ListSector<T>, at indexSet: IndexSet) {
        guard let index = indexSet.first,
              let element = sector.elements[safe: index]
        else { return }
        deleteElement?(element)
    }

    private var separator: some View {
        Color.backgroundPrimary
            .frame(height: .medium)
            .deleteDisabled(true)
    }

    private var isListWithoutSectors: Bool {
        sectors.count == 1 && sectors.first?.title == ListSector<T>.unvisibleSectorTitle
    }

    fileprivate init(
        _ title: String,
        emptyStateVD: EmptyStateVD,
        sectors: [ListSector<T>],
        deleteElement: ((T) -> Void)?,
        @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.title = title
        self.emptyStateVD = emptyStateVD
        self.sectors = sectors
        self.deleteElement = deleteElement
        self.rowView = rowView
        UITableView.appearance().sectionFooterHeight = .small
        UITableView.appearance().sectionHeaderTopPadding = .large
    }
}

// MARK: - Initializers

extension BaseList {

    init(_ title: String,
         emptyStateVD: EmptyStateVD,
         sectors: [ListSector<T>],
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(title, emptyStateVD: emptyStateVD, sectors: sectors, deleteElement: nil, rowView: rowView)
    }

    init(_ title: String,
         emptyStateVD: EmptyStateVD,
         elements: [T],
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(title, emptyStateVD: emptyStateVD, sectors: ListSector.unvisibleSector(elements), deleteElement: nil, rowView: rowView)
    }

    init(_ title: String,
         emptyStateVD: EmptyStateVD,
         elements: FetchedResults<T>,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        self.init(title, emptyStateVD: emptyStateVD, elements: elements.map { $0 }, rowView: rowView)
    }

    init<I>(_ title: String,
            emptyStateVD: EmptyStateVD,
            sectorIdMapper: (I) -> String,
            sectors: SectionedFetchResults<I, T>,
            @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        let sectors = sectors.map { ListSector(sectorIdMapper($0.id), elements: $0.map { $0 }) }
        self.init(title, emptyStateVD: emptyStateVD, sectors: sectors, rowView: rowView)
    }
}

extension BaseList {
    func onDelete(perform action: ((T) -> Void)?) -> BaseList {
        BaseList(title, emptyStateVD: emptyStateVD, sectors: sectors, deleteElement: action, rowView: rowView)
    }
}
