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
        Form {
            ListPicker(title: "From:", listView: CurrencyListView(selection: $viewModel.primaryCurrency))
            ListPicker(title: "To:", listView: CurrencyListView(selection: $viewModel.secondaryCurrency))
        }
    }
}


// MARK: - Preview

struct CantorView_Previews: PreviewProvider {
    static var previews: some View {
        CantorView()
    }
}
