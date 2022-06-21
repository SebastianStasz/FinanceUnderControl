//
//  SectoredList.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 20/06/2022.
//

import Shared
import SwiftUI

struct SectoredList<Item: Identifiable & Equatable, RowView: View>: View {
    typealias ViewModel = BaseListVM<Item>
    typealias ViewData = BaseListVD<Item>

    @ObservedObject var viewModel: ViewModel

    let viewData: ViewData
    let rowView: (Item) -> RowView

    var body: some View {
        LazyVStack(spacing: .xxlarge) {
            ForEach(viewData.sectors) { sector in
                Sector(sector.title, editAction: sector.editAction) {
                    LazyVStack(spacing: .medium) {
                        ForEach(sector.elements) {
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
        }
    }
}

