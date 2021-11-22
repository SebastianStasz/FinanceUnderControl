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
    }

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }

    func getSupportedCurrencies() -> AnyPublisher<Exchangerate, Error> {
        apiService.getContentFrom(urlString: EndPoints.symbols.rawValue)
    }
}
