//
//  CurrencyListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import CoreData
import FinanceCoreData
import SwiftUI

struct CurrencyListView: View {

    @ObservedObject var viewModel: CurrencyListVM

    var body: some View {
        FetchRequestListView(items: viewModel.currencies, rowView: CurrencyRowView.init)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText)
    }
}


// MARK: - Preview

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(viewModel: CurrencyListVM())
    }
}
