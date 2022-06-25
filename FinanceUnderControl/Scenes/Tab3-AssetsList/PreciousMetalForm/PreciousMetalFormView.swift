//
//  PreciousMetalFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import SwiftUI
import Shared

struct PreciousMetalFormView: View {

    @ObservedObject var viewModel: PreciousMetalFormVM

    var body: some View {
        FormView {
            Sector(.common_amount) {
                BaseTextField(.common_amount, viewModel: viewModel.amountInputVM, prompt: "0")
                LabeledPicker(.precious_metal_form_type_label, elements: viewModel.availableMetals, selection: $viewModel.formModel.type)
                    .enabled(!viewModel.formType.isEdit)
            }

            if let date = viewModel.formModel.lastUpdateDate {
                Sector(.common_last_edition_date) {
                    Text(date.string(format: .medium))
                        .card()
                }
            }
        }
        .navigationTitle(viewModel.formType.title)
        .closeButton(action: viewModel.binding.didTapClose.send)
        .horizontalButtons(primaryButton: primaryButton)
        .interactiveDismissDisabled(viewModel.wasEdited)
        .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_save, enabled: viewModel.formModel.isValid) { viewModel.binding.didTapConfirm.send() }
    }
}

// MARK: - Preview

struct PreciousMetalFormView_Previews: PreviewProvider {
    static var previews: some View {
        PreciousMetalFormView(viewModel: .init(formType: .new()))
        PreciousMetalFormView(viewModel: .init(formType: .new())).darkScheme()
    }
}
