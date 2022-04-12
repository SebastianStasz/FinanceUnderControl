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
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ExportFinanceDataVM()

    var body: some View {
        FormView {
            Description(.settings_export_finance_data_description)

            Sector(.common_file_name) {
                LabeledTextField(.common_file_name, viewModel: viewModel.fileNameInput, prompt: viewModel.defaultFileName)
            }
        }
        .handleViewModelActions(viewModel)
        .asSheet(title: .common_export, primaryButton: primaryButton)
        .alert(item: $viewModel.errorMessage, content: { message in
            // TODO: - Handling info
                .init(title: SwiftUI.Text("Info"), message: SwiftUI.Text(message), dismissButton: .default(SwiftUI.Text("OK"), action: { dismiss.callAsFunction() }))
        })
        .fileExporter(isPresented: $viewModel.isExporterShown, document: viewModel.financeDataFile, contentType: .json) {
            viewModel.input.exportResult.send($0)
        }
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_export, enabled: !viewModel.isLoading, action: viewModel.input.didTapExport.send)
    }
}

// MARK: - Preview

struct ExportFinanceDataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExportFinanceDataView()
            ExportFinanceDataView().darkScheme()
        }
    }
}
