//
//  APIConfigurationProtocol.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import Foundation

protocol APIConfigurationProtocol {
    var encoder: JSONEncoder { get }
}

struct APIConfiguration: APIConfigurationProtocol {
    let encoder = JSONEncoder()
}
