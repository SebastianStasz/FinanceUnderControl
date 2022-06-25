//
//  PreciousMetalFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import SwiftUI

struct PreciousMetalFormView: View {

    @ObservedObject var viewModel: PreciousMetalFormVM

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Preview

struct PreciousMetalFormView_Previews: PreviewProvider {
    static var previews: some View {
        PreciousMetalFormView(viewModel: .init(formType: .new()))
        PreciousMetalFormView(viewModel: .init(formType: .new())).darkScheme()
    }
}
