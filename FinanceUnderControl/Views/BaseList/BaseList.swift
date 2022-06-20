//
//  BaseList.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 20/06/2022.
//

import SwiftUI

struct BaseList<Item: Identifiable & Equatable, RowView: View>: View {
    typealias ViewModel = BaseListVM<Item>
    typealias ViewData = BaseListVD<Item>

    @ObservedObject var viewModel: ViewModel

    let viewData: ViewData
    let rowView: (Item) -> RowView

    var body: some View {
        LazyVStack(spacing: .medium) {
            ForEach(viewData.sectors.first?.elements ?? []) {
                rowView($0)

                if viewData.isMoreItems && viewData.sectors.last?.elements.last == $0 {
                    ProgressView()
                        .frame(height: 80)
                        .onAppear { viewModel.fetchMore.send() }
                }
            }
        }
    }
}
