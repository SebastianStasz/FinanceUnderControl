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

    @StateObject var viewModel = CantorVM()
    @State private var isInfoAlertPresented = false

    var baseBody: some View {
        FormView {
            sectorExchangeRate
            sectorConvert
            sectorMore
                .displayIf(viewModel.exchangeRateValue.notNil)
        }
        .toolbar { toolbarContent }
        .infoAlert(.common_info, isPresented: $isInfoAlertPresented, message: .cantor_exchange_rates_info_message)
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.infoCircle.name, action: showInfoAlert)
    }

    // MARK: - Interactions

    private func showInfoAlert() {
        isInfoAlertPresented = true
    }
}

// MARK: - Preview

struct CantorView_Previews: PreviewProvider {
    static var previews: some View {
        CantorView()
            .embedInNavigationView(title: "Cantor")
    }
}
