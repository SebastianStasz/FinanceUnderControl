//
//  SymbolsReponseTests.swift
//  DomainTests
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import XCTest
@testable import Domain

final class SymbolsReponseTests: XCTestCase {

    private let responseData = Data(responseDataString.utf8)
    private let expectedResult = SymbolsReponse(currencies: currencies)

    func test_decoding_LatestRatesReponse() throws {
        var result = try JSONDecoder().decode(SymbolsReponse.self, from: responseData)
        result.sortCurrencies()
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
        "symbols": {
            "AED": {
            "description": "United Arab Emirates Dirham",
            "code": "AED"
            },
            "AFN": {
            "description": "Afghan Afghani",
            "code": "AFN"
            },
            "ALL": {
            "description": "Albanian Lek",
            "code": "ALL"
            }
        }
        }
        """
    }

    static private var currencies: [CurrencyData] {
        [
            CurrencyData(code: "AED", name: "United Arab Emirates Dirham"),
            CurrencyData(code: "AFN", name: "Afghan Afghani"),
            CurrencyData(code: "ALL", name: "Albanian Lek")
        ]
    }
}
