//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import Shared
import SwiftUI
import SSUtils

struct BaseList<T: Identifiable, RowView: View>: View where T: Equatable {
    typealias ViewModel = BaseListVM<T>
    typealias ViewData = BaseListVD<T>

    @ObservedObject private var viewModel: ViewModel

    private let viewData: ViewData
    private let emptyTitle: String
    private let emptyDescription: String
    private let rowView: (T) -> RowView
    var deleteElement: ((T) -> Void)?

    var body: some View {
        List {
            Group {
                if isListWithoutSectors {
                    listForSector(viewData.sectors.first!)
                } else {
                    ForEach(viewData.sectors) { sector in
                        Section(sector.header, shouldBePresented: sector.shouldBePresented) {
                            listForSector(sector)
                        }
                    }
                }
                if viewData.isMoreItems {
                    Text("Loading").onAppear {
                        viewModel.fetchMore.send()
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
        .emptyState(isEmpty: viewData.isEmpty, isLoading: viewData.isLoading, viewData: emptyStateVD)
        .overlay(LoadingIndicator(isLoading: viewData.isLoading))
    }

    private var emptyStateVD: EmptyStateVD {
        .init(title: emptyTitle, description: emptyDescription, isSearching: viewData.isSearching)
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
        viewData.sectors.count == 1 && viewData.sectors.first?.title == ListSector<T>.unvisibleSectorTitle
    }

    fileprivate init(
        viewModel: ViewModel,
        viewData: ViewData,
        emptyTitle: String,
        emptyDescription: String,
        deleteElement: ((T) -> Void)?,
        @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.viewModel = viewModel
        self.viewData = viewData
        self.emptyTitle = emptyTitle
        self.emptyDescription = emptyDescription
        self.deleteElement = deleteElement
        self.rowView = rowView
        UITableView.appearance().sectionFooterHeight = .small
        UITableView.appearance().sectionHeaderTopPadding = .large
    }
}

// MARK: - Initializers

extension BaseList {

    init(viewModel: ViewModel,
         viewData: ViewData,
         emptyTitle: String,
         emptyDescription: String,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(viewModel: viewModel, viewData: viewData, emptyTitle: emptyTitle, emptyDescription: emptyDescription, deleteElement: nil, rowView: rowView)
    }
}

extension BaseList {
    func onDelete(perform action: ((T) -> Void)?) -> BaseList {
        BaseList(viewModel: viewModel, viewData: viewData, emptyTitle: emptyTitle, emptyDescription: emptyDescription, deleteElement: action, rowView: rowView)
    }
}
