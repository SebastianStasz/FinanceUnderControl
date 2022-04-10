//
//  ExportFinanceDataView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct ExportFinanceDataView: View {
    @StateObject private var viewModel = ExportFinanceDataVM()

    var body: some View {
        FormView {
            Sector(.common_file_name) {
                LabeledTextField(.common_file_name, viewModel: viewModel.fileNameInput, prompt: viewModel.defaultFileName)
            }

            if let financeStorage = viewModel.financeStorage {
                Sector(.settings_your_finance_data) {
                    Group {
                        Text("\(String.common_groups): \(financeStorage.groups.count)")
                        Text("\(String.common_categories): \(financeStorage.categories.count)")
                        Text("\(String.tab_cashFlow_title): \(financeStorage.cashFlows.count)")
                    }
                    .card()
                }
            }
        }
        .handleViewModelActions(viewModel)
        .asSheet(title: .common_export, primaryButton: primaryButton)
        .activitySheet($viewModel.activityAction)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_export, enabled: !viewModel.isLoading, action: viewModel.input.didTapExport.send)
    }
}

// MARK: - Preview

struct ExportFinanceDataView_Previews: PreviewProvider {
    static var previews: some View {
        ExportFinanceDataView()
    }
}
