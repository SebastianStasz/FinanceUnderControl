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
            Sector("File name") {
                LabeledTextField("File name", viewModel: viewModel.fileNameInput, prompt: viewModel.defaultFileName)
            }

            if let financeStorage = viewModel.financeStorage {
                Sector("Finance data") {
                    Group {
                        Text("Groups: \(financeStorage.groups.count)")
                        Text("Categories: \(financeStorage.categories.count)")
                        Text("Cash flows: \(financeStorage.cashFlows.count)")
                    }
                    .card()
                }
            }
        }
        .handleViewModelActions(viewModel)
        .asSheet(title: "Export data", primaryButton: primaryButton)
        .activitySheet($viewModel.activityAction)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init("Export", enabled: !viewModel.isLoading, action: viewModel.input.didTapExport.send)
    }
}

// MARK: - Preview

struct ExportFinanceDataView_Previews: PreviewProvider {
    static var previews: some View {
        ExportFinanceDataView()
    }
}
