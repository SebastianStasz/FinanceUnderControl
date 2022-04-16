//
//  GetLatestExchangeRatesRequest.swift
//  Domain
//
//  Created by sebastianstaszczyk on 28/03/2022.
//

import Foundation
import Shared

public struct GetLatestExchangeRatesRequest: APIRequest {
    private let currency: String

    public init(for currency: String) {
        self.currency = currency
    }
}

public extension GetLatestExchangeRatesRequest {
    var method: RequestMethod { .GET }

    var path: String {
        "/latest"
    }

    var queryParams: [String: String] {
        ["base": currency,
         "symbols": Currency.allCases.map { $0.code }.joined(separator: ",") ]
    }
}
