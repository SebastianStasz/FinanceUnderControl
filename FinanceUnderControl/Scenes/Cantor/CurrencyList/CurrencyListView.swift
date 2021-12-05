//
//  CurrencyListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import CoreData
import FinanceCoreData
import SwiftUI

struct CurrencyListView: PickerList {

    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CurrencyListVM()

    var selection: Binding<CurrencyEntity?>
    private let buttonType: BaseRowButtonType

    init(selection: Binding<CurrencyEntity?>, buttonType: BaseRowButtonType = .none) {
        self.selection = selection
        self.buttonType = buttonType
    }

    var body: some View {
        BaseListViewFetchRequest(items: viewModel.currencies) {
            CurrencyRowView(currency: $0)
                .baseRowView(buttonType: getButtonType(for: $0), action: selectCurrency($0))
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
    }

    private func getButtonType(for currency: CurrencyEntity) -> BaseRowButtonType {
        selection.wrappedValue == currency ? .selected : .none
    }

    // MARK: - Interactions

    private func selectCurrency(_ currenyEntity: CurrencyEntity) {
        selection.wrappedValue = currenyEntity
        dismiss()
    }
}


// MARK: - Preview

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(selection: .constant(nil))
            .embedInNavigationView(title: "Currencies")
            .environment(\.managedObjectContext, PersistenceController.preview.context)
//            .environment(\.managedObjectContext, PersistenceController.previewEmpty.context)
    }
}
