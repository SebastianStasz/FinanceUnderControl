//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import Shared
import Firebase
import SwiftUI

struct CashFlowFilterView: BaseView {
    @ObservedObject var viewModel: CashFlowFilterVM

    var baseBody: some View {
        FormView {
            Sector(.cash_flow_filter_type) {
                SegmentedPicker(.cash_flow_filter_type, selection: filter.cashFlowSelection, elements: CashFlowSelection.allCases)
                LabeledPicker(.common_category, elements: viewModel.categories, selection: filter.cashFlowCategory)
                    .displayIf(filter.wrappedValue.cashFlowSelection != .all, withTransition: .scale)
            }
            Sector(.common_amount) {
                LabeledPicker(.create_cash_flow_currency, elements: currenciesToSelect, selection: filter.currency)
            }
            Sector(.cash_flow_filter_other) {
                MonthAndYearPicker(.cash_flow_filter_date_range, viewData: filter.datePickerViewData)
            }
        }
        .closeButton { viewModel.binding.dismiss.send() }
        .horizontalButtons(primaryButton: .init(.button_apply, action: viewModel.binding.applyFilters.send),
                           secondaryButton: .init(.button_reset, action: viewModel.binding.resetFilters.send))
    }

    private var filter: Binding<CashFlowFilter> {
        $viewModel.filter
    }

    private var currenciesToSelect: [Currency?] {
        var currencies: [Currency?] = Currency.allCases
        currencies.append(nil)
        return currencies
    }

    private var yearsToSelect: [Int?] {
        let year = Calendar.current.component(.year, from: Date())
        var years: [Int?] = (2020...year).map { $0 }
        years.append(nil)
        return years
    }

    private var monthsToSelect: [Int?] {
        var months: [Int?] = (1...12).map { $0 }
        months.append(nil)
        return months
    }
}

// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseApp.configure()
        let viewModel = CashFlowFilterVM()
        return Group {
            CashFlowFilterView(viewModel: viewModel)
            CashFlowFilterView(viewModel: viewModel).darkScheme()
        }
    }
}
