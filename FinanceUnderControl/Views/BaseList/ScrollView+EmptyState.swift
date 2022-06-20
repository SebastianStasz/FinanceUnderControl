//
//  ScrollView+EmptyState.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 20/06/2022.
//

import SwiftUI

extension ScrollView {
    func emptyState<T: Identifiable & Equatable>(listVD: BaseListVD<T>, title: String, description: String, isSearching: Bool = false) -> some View {
        emptyState(isEmpty: listVD.isEmpty, isLoading: listVD.isLoading, viewData: .init(title: title, description: description, isSearching: isSearching))
    }
}
