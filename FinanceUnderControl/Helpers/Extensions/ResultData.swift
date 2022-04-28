//
//  ResultData.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 27/04/2022.
//

import Foundation
import Shared

struct ResultData {
    let type: ResultViewType
    let title: String
    let message: String
    let action: Action?

    public static func success(title: String = "Success", message: String, action: Action? = nil) -> ResultData {
        .init(type: .success, title: title, message: message, action: action)
    }

    public static func error(title: String = "Error", message: String, action: Action? = nil) -> ResultData {
        .init(type: .error, title: title, message: message, action: action)
    }
}
