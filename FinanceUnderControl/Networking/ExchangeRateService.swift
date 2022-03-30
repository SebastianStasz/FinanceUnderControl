//
//  ExchangeRateService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/03/2022.
//

import Domain
import Foundation

final class ExchangeRateService {

    private let apiService: APIService

    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }

    func getLatestExchangeRates(for currency: String) async throws -> LatestRatesResponse {
        try await apiService.execute(GetLatestExchangeRatesRequest(for: currency), type: .exchangerate)
    }
}
