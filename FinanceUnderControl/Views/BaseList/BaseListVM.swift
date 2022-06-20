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
        let viewData = CombineLatest4(input.sectors, input.isMoreItems, input.isLoading, input.isSearching)
            .map { ViewData(sectors: $0.0, isMoreItems: $0.1, isLoading: $0.2, isSearching: $0.3) }

        return Output(viewData: viewData.asDriver,
                      fetchMore: fetchMore.asDriver)
    }
}

extension BaseListVM.Input {
    init(sectors: Driver<[ListSector<T>]>, isLoading: Driver<Bool> = Just(false).asDriver) {
        self.sectors = sectors
        self.isMoreItems = Just(false).asDriver
        self.isSearching = Just(false).asDriver
        self.isLoading = isLoading
    }

    init(elements: Driver<[T]>) {
        self.sectors = elements.map { [ListSector<T>("", elements: $0)] }.asDriver
        self.isMoreItems = Just(false).asDriver
        self.isSearching = Just(false).asDriver
        self.isLoading = Just(false).asDriver
    }
}
