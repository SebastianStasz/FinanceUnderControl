//
//  BaseButton.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/01/2022.
//

import SwiftUI
import SSUtils

public struct BaseButton: View {

    private let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public init(_ title: String, role: Role, enabled: Bool = true, action: @escaping Action) {
        configuration = .init(title, role: role, enabled: enabled, action: action)
    }

    public var body: some View {
        Button(configuration.title, action: configuration.action)
            .buttonStyle(BaseButtonStyle(role: configuration.role))
            .disabled(!configuration.enabled)
    }
}
