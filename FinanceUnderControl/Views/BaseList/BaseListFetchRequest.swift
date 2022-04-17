//
//  BaseListViewFetchRequest.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import Shared
import SwiftUI

struct BaseListFetchRequest<T: Entity, Content: View>: View {

    @FetchRequest private var items: FetchedResults<T>
    private let title: String
    private let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    private let emptyStateVD: EmptyStateVD
    private let rowView: (T) -> Content

    init(items: FetchRequest<T>,
         title: String,
         titleDisplayMode: NavigationBarItem.TitleDisplayMode = .automatic,
         emptyStateVD: EmptyStateVD,
         @ViewBuilder rowView: @escaping (T) -> Content
    ) {
        self._items = items
        self.title = title
        self.titleDisplayMode = titleDisplayMode
        self.emptyStateVD = emptyStateVD
        self.rowView = rowView
    }

    private var itemsArray: [T] {
        items.map { $0 }
    }

    var body: some View {
        BaseList(title, emptyStateVD: emptyStateVD, elements: itemsArray, rowView: rowView)
    }
}
