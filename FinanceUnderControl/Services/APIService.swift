//
//  APIService.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Combine
import Foundation

protocol APIServiceProtocol {
    func getContentFrom<T: Decodable>(urlString: String) -> AnyPublisher<T, Error>
    func getContentFrom<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
}

final class APIService: APIServiceProtocol {
    static let shared = APIService()
    private init() {}

    private lazy var decoder = JSONDecoder()

    func getContentFrom<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        return getContentFrom(url: url)
    }
    
    func getContentFrom<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
