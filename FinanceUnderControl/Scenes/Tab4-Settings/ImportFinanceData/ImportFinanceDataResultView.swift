//
//  ImportFinanceDataResultView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/04/2022.
//

import Shared
import SwiftUI

struct ImportFinanceDataResultView: View {

    @ObservedObject var viewModel: ImportFinanceDataVM

    var body: some View {
        FormView {
            if let result = viewModel.importer?.importResult {
                Text("Oto zaimportowane dane. Zajdziesz tutaj informacje, które element zostaną utworzone, a które już istnieją w aplikacji. Jeżeli wszystko się zgadza kliknij \"Zatwierdź\".", style: .footnote(.info)
                )
                .padding(.horizontal, .medium)

                Sector("Imported data") {
                    Navigation("New groups: \(result.groups.countNew)") {
                        ImportFinanceResultList(.common_groups, items: result.groups)
                    }
                    Navigation("New categories: \(result.categories.countNew)") {
                        ImportFinanceResultList(.common_categories, items: result.categories)
                    }
                    Navigation("New cash flows: \(result.cashFlows.countNew)") {
                        ImportFinanceResultList("Cash flows", items: result.cashFlows)
                    }
                }
            }
        }
        .handleViewModelActions(viewModel)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HorizontalButtons(primaryButton: primaryButton)
            }
        }
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init("Zatwierdź", enabled: !viewModel.isLoading, action: {
            viewModel.input.didConfirmImporting.send()
        })
    }
}

// MARK: - Preview

struct ImportFinanceDataResultView_Previews: PreviewProvider {
    static var previews: some View {
        ImportFinanceDataResultView(viewModel: .init())
    }
}
