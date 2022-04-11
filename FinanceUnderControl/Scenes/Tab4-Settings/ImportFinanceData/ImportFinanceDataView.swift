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
            Text("W tym miejscu możesz zaimportować zapisane wcześniej dane finansowe włączając w to przepływy pieniężne, kategorie i grupy. Wybierz plik i przejrzyj potencjalne zmiany.", style: .footnote(.info))
                .padding(.horizontal, .medium)

            if let selectedFile = viewModel.selectedFile {
                Sector("Imported data") {
                    Text(selectedFile.lastPathComponent).card(style: .primary)
                    Navigation("See result", leadsTo: ImportFinanceDataResultView(viewModel: viewModel))
                }
            }
        }
        .handleViewModelActions(viewModel)
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
