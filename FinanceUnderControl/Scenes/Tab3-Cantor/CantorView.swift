//
//  CantorView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import FinanceCoreData
import Shared
import SSUtils
import SwiftUI
import SSValidation

struct CantorView: BaseView {

    @FetchRequest(sortDescriptors: [CurrencyEntity.Sort.byCode(.forward).nsSortDescriptor]
    ) var currencies: FetchedResults<CurrencyEntity>

    @ObservedObject var viewModel: CantorVM
    @State private var isInfoAlertPresented = false

    var baseBody: some View {
        FormView {
            sectorExchangeRate
            sectorConvert
            sectorMore
        }
        .navigationTitle(String.tab_currencies_title)
        .toolbar { Toolbar.trailing(systemImage: SFSymbol.infoCircle.name, action: showInfoAlert) }
        .infoAlert(.common_info, isPresented: $isInfoAlertPresented, message: .cantor_exchange_rates_info_message)
    }

    // MARK: - Interactions

    private func showInfoAlert() {
        isInfoAlertPresented = true
    }
}

// MARK: - Preview

struct CantorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CantorVM(coordinator: PreviewCoordinator())
        CantorView(viewModel: viewModel)
        CantorView(viewModel: viewModel).darkScheme()
    }
}
