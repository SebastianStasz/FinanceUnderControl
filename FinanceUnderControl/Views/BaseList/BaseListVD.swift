//
//  BaseListVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 20/05/2022.
//

import Foundation

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
