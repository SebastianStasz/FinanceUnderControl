//
//  ResultVD.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/04/2022.
//

import Foundation

public struct ResultVD {
    public let type: ResultViewType
    public let title: String
    public let message: String
    public let action: Action

    public init(type: ResultViewType, title: String, message: String, action: @escaping Action) {
        self.type = type
        self.title = title
        self.message = message
        self.action = action
    }

    public static func success(title: String = "Success", message: String, action: @escaping Action) -> ResultVD {
        .init(type: .success, title: title, message: message, action: action)
    }

    public static func error(title: String = "Error", message: String, action: @escaping Action) -> ResultVD {
        .init(type: .error, title: title, message: message, action: action)
    }
}
