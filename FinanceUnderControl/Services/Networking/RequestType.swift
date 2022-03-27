//
//  RequestType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import Foundation

enum RequestType: String {
    case exchangerate = "https://api.exchangerate.host"

    var baseURL: URL {
        URL(string: rawValue)!
    }
}
