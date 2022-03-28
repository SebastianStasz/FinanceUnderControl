//
//  RequestType.swift
//  Domain
//
//  Created by sebastianstaszczyk on 28/03/2022.
//

import Foundation

public enum RequestType: String {
    case exchangerate = "https://api.exchangerate.host"

    var baseURL: URL {
        URL(string: rawValue)!
    }
}
