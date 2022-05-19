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

    @Binding private var isMoreItems: Bool

    private let isLoading: Bool
    private let emptyStateVD: EmptyStateVD
    private let sectors: [ListSector<T>]
    private let rowView: (T) -> RowView
    private let onLastItemAppear: DriverSubject<Void>?
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
                if isMoreItems {
                    Text("Loading").onAppear {
                        onLastItemAppear?.send()
                        isMoreItems = false
                    }
                }
            }
            .listRowBackground(Color.backgroundPrimary)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal, .large)
        }
        .listStyle(.grouped)
        .padding(.bottom, .xxlarge)
        .background(Color.backgroundPrimary)
        .environment(\.defaultMinListRowHeight, 1)
        .environment(\.defaultMinListHeaderHeight, 1)
        .emptyState(isEmpty: sectors.isEmpty, isLoading: isLoading, viewData: emptyStateVD)
        .overlay(LoadingIndicator(isLoading: isLoading))
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
        isLoading: Bool,
        emptyStateVD: EmptyStateVD,
        sectors: [ListSector<T>],
        deleteElement: ((T) -> Void)?,
        onLastItemAppear: DriverSubject<Void>?,
        isMoreItems: Binding<Bool>,
        @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.isLoading = isLoading
        self.emptyStateVD = emptyStateVD
        self.sectors = sectors
        self.deleteElement = deleteElement
        self.onLastItemAppear = onLastItemAppear
        self._isMoreItems = isMoreItems
        self.rowView = rowView
        UITableView.appearance().sectionFooterHeight = .small
        UITableView.appearance().sectionHeaderTopPadding = .large
    }
}

// MARK: - Initializers

extension BaseList {

    init(isLoading: Bool = false,
         emptyStateVD: EmptyStateVD,
         sectors: [ListSector<T>],
         onLastItemAppear: DriverSubject<Void>? = nil,
         isMoreItems: Binding<Bool> = .constant(false),
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(isLoading: isLoading, emptyStateVD: emptyStateVD, sectors: sectors, deleteElement: nil, onLastItemAppear: onLastItemAppear, isMoreItems: isMoreItems, rowView: rowView)
    }

    init(isLoading: Bool = false,
         emptyStateVD: EmptyStateVD,
         elements: [T],
         onLastItemAppear: DriverSubject<Void>? = nil,
         isMoreItems: Binding<Bool> = .constant(false),
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(isLoading: isLoading, emptyStateVD: emptyStateVD, sectors: ListSector.unvisibleSector(elements), deleteElement: nil, onLastItemAppear: onLastItemAppear, isMoreItems: isMoreItems, rowView: rowView)
    }

    init(isLoading: Bool = false,
         emptyStateVD: EmptyStateVD,
         elements: FetchedResults<T>,
         onLastItemAppear: DriverSubject<Void>? = nil,
         isMoreItems: Binding<Bool> = .constant(false),
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        self.init(isLoading: isLoading, emptyStateVD: emptyStateVD, elements: elements.map { $0 }, onLastItemAppear: onLastItemAppear, isMoreItems: isMoreItems, rowView: rowView)
    }

    init<I>(isLoading: Bool = false,
            emptyStateVD: EmptyStateVD,
            sectorIdMapper: (I) -> String,
            sectors: SectionedFetchResults<I, T>,
            onLastItemAppear: DriverSubject<Void>? = nil,
            isMoreItems: Binding<Bool> = .constant(false),
            @ViewBuilder rowView: @escaping (T) -> RowView
    ) where T: Entity {
        let sectors = sectors.map { ListSector(sectorIdMapper($0.id), elements: $0.map { $0 }) }
        self.init(isLoading: isLoading, emptyStateVD: emptyStateVD, sectors: sectors, onLastItemAppear: onLastItemAppear, isMoreItems: isMoreItems, rowView: rowView)
    }
}

extension BaseList {
    func onDelete(perform action: ((T) -> Void)?) -> BaseList {
        BaseList(isLoading: isLoading, emptyStateVD: emptyStateVD, sectors: sectors, deleteElement: action, onLastItemAppear: onLastItemAppear, isMoreItems: _isMoreItems, rowView: rowView)
    }
}
