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

    var body: some View {
        Text("Content")
            .handleViewModelActions(viewModel)
            .asSheet(title: .common_import, primaryButton: primaryButton)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_import, enabled: !viewModel.isLoading, action: viewModel.input.didTapExport.send)
    }
}

// MARK: - Preview

struct ImportFinanceDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImportFinanceDataView()
    }
}
