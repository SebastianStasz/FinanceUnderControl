//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import FinanceCoreData
import SwiftUI
import SSUtils

extension BaseList {
    func onDelete(perform action: ((IndexSet) -> Void)?) -> BaseList {
        BaseList(title, emptyMessage: emptyMessage, sectors: sectors, deleteElement: action, rowView: rowView)
    }
}

struct BaseList<T: Identifiable, RowView: View>: View where T: Equatable {

    private let title: String
    private let emptyMessage: String?
    private let sectors: [SectorVD<T>]
    private let rowView: (T) -> RowView
    var deleteElement: ((IndexSet) -> Void)?

    private var isListWithoutSectors: Bool {
        sectors.count == 1 && sectors.first?.title == SectorVD<T>.unvisibleSectorTitle
    }

    var body: some View {
        List {
            Group {
                if isListWithoutSectors { listForElements(sectors.first!.elements) }
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

    @ViewBuilder
    private var listWithSectors: some View {
        ForEach(sectors) { sector in
            if sector.isNotEmpty || sector.visibleIfEmpty {
                Section(sector.title, onEdit: sector.editAction) { listForElements(sector.elements) }
            }
        }
    }

    @ViewBuilder
    private func listForElements(_ elements: [T]) -> some View {
        ForEach(elements) { rowView($0) ; separator }
            .onDelete(perform: deleteElement)
    }

    private var separator: some View {
        Color.backgroundPrimary
            .frame(height: .small)
            .deleteDisabled(true)
    }

    // MARK: - Initializers

    fileprivate init(_ title: String,
                     emptyMessage: String?,
                     sectors: [SectorVD<T>],
                     deleteElement: ((IndexSet) -> Void)?,
                     @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.title = title
        self.emptyMessage = emptyMessage
        self.sectors = sectors
        self.deleteElement = deleteElement
        self.rowView = rowView
    }

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: [T],
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.title = title
        self.emptyMessage = emptyMessage
        self.sectors = SectorVD.unvisibleSector(elements)
        self.rowView = rowView
        UITableView.appearance().sectionFooterHeight = .small
        UITableView.appearance().sectionHeaderTopPadding = .large
    }

    init(_ title: String,
         emptyMessage: String? = nil,
         sectors: [SectorVD<T>],
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.title = title
        self.emptyMessage = emptyMessage
        self.sectors = sectors
        self.rowView = rowView
        UITableView.appearance().sectionFooterHeight = .small
        UITableView.appearance().sectionHeaderTopPadding = .large
    }

    init(_ title: String,
         emptyMessage: String? = nil,
         elements: FetchedResults<T>,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        self.init(title, emptyMessage: emptyMessage, elements: elements.map { $0 }, rowView: rowView)
    }
}
