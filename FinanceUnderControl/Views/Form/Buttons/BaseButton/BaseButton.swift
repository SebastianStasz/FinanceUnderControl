//
//  BaseButton.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/01/2022.
//

import SwiftUI
import SSUtils

struct BaseButton: View {

    private let configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    init(_ title: String, role: Role, action: @escaping Action) {
        configuration = .init(title, role: role, action: action)
    }

    var body: some View {
        Button(configuration.title, action: configuration.action)
            .buttonStyle(BaseButtonStyle(role: configuration.role))
    }
}
