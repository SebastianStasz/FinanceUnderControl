//
//  ExchangerateService.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Combine
import Domain
import Foundation

final class ExchangerateService {
    private let apiService: APIServiceProtocol

    private enum EndPoints: String {
        case symbols = "https://api.exchangerate.host/symbols"
        case latestRates = "https://api.exchangerate.host/latest?base="
    }

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }

    func getSupportedCurrencies() -> AnyPublisher<SymbolsReponse, Error> {
        apiService.getContentFrom(urlString: EndPoints.symbols.rawValue)
    }

    func getExchangeRates(for currency: String) -> AnyPublisher<LatestRatesResponse, Error> {
        apiService.getContentFrom(urlString: EndPoints.latestRates.rawValue + currency)
    }
}
