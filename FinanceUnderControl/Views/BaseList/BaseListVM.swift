//
//  BaseListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 20/05/2022.
//

import Combine
import Foundation
import SSUtils

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

extension BaseListVM.Input {
    init(sectors: Driver<[ListSector<T>]>, isLoading: Driver<Bool>) {
        self.sectors = sectors
        self.isMoreItems = Just(false).asDriver
        self.isSearching = Just(false).asDriver
        self.isLoading = isLoading
    }

    init(elements: Driver<[T]>) {
        self.sectors = elements.map { [ListSector<T>(ListSector<T>.unvisibleSectorTitle, elements: $0)] }.asDriver
        self.isMoreItems = Just(false).asDriver
        self.isSearching = Just(false).asDriver
        self.isLoading = Just(false).asDriver
    }
}
