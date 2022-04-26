//
//  ResultVD.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/04/2022.
//

import Foundation

public struct ResultVD {
    let type: ResultViewType
    let title: String
    let message: String
    let action: Action

    public static func success(title: String = "Success", message: String, action: @escaping Action) -> ResultVD {
        .init(type: .success, title: title, message: message, action: action)
    }

    public static func error(title: String = "Error", message: String, action: @escaping Action) -> ResultVD {
        .init(type: .error, title: title, message: message, action: action)
    }
}
