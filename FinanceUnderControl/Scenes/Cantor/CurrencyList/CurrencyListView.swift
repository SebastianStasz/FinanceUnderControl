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
        FetchRequestListView(items: viewModel.currencies) {
            CurrencyRowView(currency: $0)
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
    }
}


// MARK: - Preview

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(viewModel: CurrencyListVM())
            .embedInNavigationView(title: "Currencies")
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
