//
//  LatestRatesReponseTests.swift
//  DomainTests
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import XCTest
@testable import Domain

final class LatestRatesReponseTests: XCTestCase {

    private let responseData = Data(responseDataString.utf8)
    private let expectedResult = LatestRatesResponse(base: "PLN", dateStr: "2021-11-23", rates: exchangeRates)

    func test_decoding_LatestRatesReponse() throws {
        var result = try JSONDecoder().decode(LatestRatesResponse.self, from: responseData)
        result.sortRates()
        XCTAssertEqual(result, expectedResult)
    }

    static private var responseDataString: String {
        """
        {
        "motd": {
            "msg": "If you or your company use this project or like what we doing, please consider backing us so we can continue maintaining and evolving this project.",
            "url": "https://exchangerate.host/#/donate"
        },
        "success": true,
        "base": "PLN",
        "date": "2021-11-23",
        "rates": {
            "AED": 0.876566,
            "AFN": 22.375258,
            "ALL": 25.775489,
            "PLN": 1.0,
            }
        }
        """
    }

    static private var exchangeRates: [ExchangeRate] {
        [
            ExchangeRate(code: "AED", rate: 0.876566),
            ExchangeRate(code: "AFN", rate: 22.375258),
            ExchangeRate(code: "ALL", rate: 25.775489)
        ]
    }
}
