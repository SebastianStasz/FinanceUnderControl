//
//  ImportFinanceDataView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/04/2022.
//

import Shared
import SwiftUI

struct ImportFinanceDataView: View {

    @StateObject private var viewModel = ImportFinanceDataVM()
    @State private var isFileImporterShown = false

    var body: some View {
        FormView {
            Description(.settings_import_finance_data_description)
        }
        .handleViewModelActions(viewModel)
        .navigation(item: $viewModel.importer, destination: { _ in
            ImportFinanceDataResultView(viewModel: viewModel)
        })
        .asSheet(title: .common_import, primaryButton: primaryButton)
        .fileImporter(isPresented: $isFileImporterShown, allowedContentTypes: [.json]) {
            viewModel.input.didSelectFile.send($0)
        }
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init("Select file", enabled: !viewModel.isLoading, action: selectFile)
    }

    private func selectFile() {
        isFileImporterShown = true
    }
}

// MARK: - Preview

struct ImportFinanceDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImportFinanceDataView()
    }
}
