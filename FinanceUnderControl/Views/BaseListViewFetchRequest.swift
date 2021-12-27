//
//  BaseListViewFetchRequest.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import SwiftUI

struct BaseListViewFetchRequest<T: Entity, Content: View>: View {

    @FetchRequest private var items: FetchedResults<T>
    private let title: String
    private let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    private let emptyMessage: String?
    private let rowView: (T) -> Content

    init(items: FetchRequest<T>,
         title: String,
         titleDisplayMode: NavigationBarItem.TitleDisplayMode = .automatic,
         emptyMessage: String? = nil,
         @ViewBuilder rowView: @escaping (T) -> Content
    ) {
        self._items = items
        self.title = title
        self.titleDisplayMode = titleDisplayMode
        self.emptyMessage = emptyMessage
        self.rowView = rowView
    }

    private var itemsArray: [T] {
        items.map { $0 }
    }

    var body: some View {
        ForEach(items, content: rowView)
            .baseListStyle(title: "Currencies", isEmpty: false)
    }
}
