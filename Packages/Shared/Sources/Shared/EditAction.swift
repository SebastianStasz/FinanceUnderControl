//
//  EditAction.swift
//  Shared
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import Foundation

public struct EditAction {
    public let title: String
    public let action: Action

    public init(title: String, action: @escaping Action) {
        self.title = title
        self.action = action
    }
}
