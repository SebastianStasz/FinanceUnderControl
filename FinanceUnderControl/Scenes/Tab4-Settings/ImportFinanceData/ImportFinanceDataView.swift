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
            Text("Możesz zaimportować zapisane wcześniej dane finansowe włączajc w to przepływy pieniężne, kategorie i grupy. Wybierz plik i wskaż, które dane mają zostać zapisane.", style: .footnote(.info))
                .padding(.horizontal, .medium)

            if let selectedFile = viewModel.selectedFile {
                Sector("Imported data") {
                    Text(selectedFile).card(style: .primary)
                    Navigation("Customize", leadsTo: Text("Customize"))
                }
            }
        }
        .handleViewModelActions(viewModel)
        .asSheet(title: .common_import, primaryButton: primaryButton)
        .fileImporter(isPresented: $isFileImporterShown, allowedContentTypes: [.json]) {
            viewModel.isLoading = true
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
