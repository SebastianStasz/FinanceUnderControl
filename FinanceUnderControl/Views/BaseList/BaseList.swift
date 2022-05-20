//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import Combine
import FinanceCoreData
import Shared
import SwiftUI
import SSUtils

struct BaseListVD<T: Identifiable & Equatable> {
    let sectors: [ListSector<T>]
    let isMoreItems: Bool
    let isLoading: Bool
    let isSearching: Bool

    var isEmpty: Bool {
        sectors.isEmpty
    }

    static var initialState: Self {
        .init(sectors: [], isMoreItems: false, isLoading: true, isSearching: false)
    }
}

final class BaseListVM<T: Identifiable & Equatable>: ObservableObject {
    typealias ViewData = BaseListVD<T>

    struct Input {
        let sectors: Driver<[ListSector<T>]>
        let isMoreItems: Driver<Bool>
        let isSearching: Driver<Bool>
        let isLoading: Driver<Bool>
    }

    struct Output {
        let viewData: Driver<ViewData>
        let fetchMore: Driver<Void>
    }

    let fetchMore = DriverSubject<Void>()

    func transform(input: Input) -> Output {

        let isMoreItems = Merge(fetchMore.map { false }, input.isMoreItems)

        let viewData = CombineLatest4(input.sectors, isMoreItems, input.isLoading, input.isSearching)
            .map { ViewData(sectors: $0.0, isMoreItems: $0.1, isLoading: $0.2, isSearching: $0.3) }

        return Output(viewData: viewData.asDriver,
                      fetchMore: fetchMore.asDriver)
    }
}

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
         onLastItemAppear: DriverSubject<Void>? = nil,
         @ViewBuilder rowView: @escaping (T) -> RowView
    ) {
        self.init(viewModel: viewModel, viewData: viewData, emptyTitle: emptyTitle, emptyDescription: emptyDescription, deleteElement: nil, rowView: rowView)
    }

//    init(viewData: ViewData,
//         emptyStateVD: EmptyStateVD,
//         @ViewBuilder rowView: @escaping (T) -> RowView
//    ) {
//        self.init(isLoading: isLoading, emptyStateVD: emptyStateVD, sectors: ListSector.unvisibleSector(elements), deleteElement: nil, onLastItemAppear: onLastItemAppear, isMoreItems: isMoreItems, rowView: rowView)
//    }

//    init(isLoading: Bool = false,
//         emptyStateVD: EmptyStateVD,
//         elements: FetchedResults<T>,
//         onLastItemAppear: DriverSubject<Void>? = nil,
//         isMoreItems: Binding<Bool> = .constant(false),
//         @ViewBuilder rowView: @escaping (T) -> RowView
//    ) where T: Entity {
//        self.init(isLoading: isLoading, emptyStateVD: emptyStateVD, elements: elements.map { $0 }, onLastItemAppear: onLastItemAppear, isMoreItems: isMoreItems, rowView: rowView)
//    }
}

extension BaseList {
    func onDelete(perform action: ((T) -> Void)?) -> BaseList {
        BaseList(viewModel: viewModel, viewData: viewData, emptyTitle: emptyTitle, emptyDescription: emptyDescription, deleteElement: action, rowView: rowView)
    }
}
