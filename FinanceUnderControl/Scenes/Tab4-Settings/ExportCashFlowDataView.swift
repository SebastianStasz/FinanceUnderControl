//
//  ExportCashFlowDataView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct ExportCashFlowDataView: View {
    @StateObject private var viewModel = ExportCashFlowDataVM()

    var body: some View {
        FormView {
            Sector("File name") {
                LabeledTextField("File name", viewModel: viewModel.fileNameInput, prompt: viewModel.defaultFileName)
            }
        }
        .handleViewModelActions(viewModel)
        .asSheet(title: "Export data", primaryButton: primaryButton)
        .activitySheet($viewModel.activityItem)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init("Export", enabled: !viewModel.isLoading, action: viewModel.input.didTapExport.send)
    }
}

// MARK: - Preview

struct ExportCashFlowDataView_Previews: PreviewProvider {
    static var previews: some View {
        ExportCashFlowDataView()
    }
}
