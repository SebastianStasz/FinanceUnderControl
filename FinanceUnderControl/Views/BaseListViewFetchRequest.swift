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
    private let emptyMessage: String?
    private let rowView: (T) -> Content

    init(items: FetchRequest<T>,
         emptyMessage: String? = nil,
         @ViewBuilder rowView: @escaping (T) -> Content
    ) {
        self._items = items
        self.emptyMessage = emptyMessage
        self.rowView = rowView
    }

    private var itemsArray: [T] {
        items.map { $0 }
    }

    var body: some View {
        BaseListView(items: itemsArray,
                     emptyMessage: emptyMessage,
                     rowView: rowView)
    }
}
