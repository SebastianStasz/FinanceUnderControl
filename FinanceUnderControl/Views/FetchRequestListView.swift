//
//  FetchRequestListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import FinanceCoreData
import SwiftUI

struct FetchRequestListView<T: Entity, Content: View>: View {

    @FetchRequest var items: FetchedResults<T>
    let rowView: (T) -> Content

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    rowView(item)
                    Divider()
                }.padding(.horizontal, .medium)
            }
        }
    }
}
