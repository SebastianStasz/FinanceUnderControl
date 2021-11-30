//
//  CantorView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import SwiftUI

struct CantorView: View {

    @StateObject private var viewModel = CantorVM()

    var body: some View {
        NavigationLink("All currencies", destination: CurrencyListView(viewModel: viewModel.currencyListVM, buttonType: .forward))
    }
}


// MARK: - Preview

struct CantorView_Previews: PreviewProvider {
    static var previews: some View {
        CantorView()
    }
}
