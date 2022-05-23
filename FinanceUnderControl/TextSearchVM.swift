//
//  TextSearchVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/05/2022.
//

import Combine
import Foundation
import SSUtils

final class TextSearchVM {

    struct Output {
        let searchText: Driver<String>
        let isSearching: Driver<Bool>
    }

    func transform(_ searchText: Driver<String>) -> Output {
        let text = searchText
            .map { $0.count < 3 ? "" : $0 }
            .removeDuplicates()

        let searchText = text
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)

        let isSearching = text
            .map { $0.isNotEmpty }
            .removeDuplicates()

        return Output(searchText: searchText.asDriver,
                      isSearching: isSearching.asDriver
        )
    }
}
