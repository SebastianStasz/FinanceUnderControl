//
//  APIService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import Combine
import Foundation
import SSUtils

enum APIError: Error {
    case other(Error)
    case decoding(Error)
    case unknown
}

final class APIService {
    static let shared = APIService()

    private let configuration: APIConfigurationProtocol

    init(configuration: APIConfigurationProtocol = APIConfiguration()) {
        self.configuration = configuration
    }

    func execute<Model: Decodable>(_ request: APIRequest, type: RequestType) -> AnyPublisher<Model, Error> {
        Just(()).await { [unowned self] in
            try await self.execute(request, type: type)
        }
        .eraseToAnyPublisher()
    }

    func execute<Model: Decodable>(_ request: APIRequest, type: RequestType) async throws -> Model {
        let request = request.getURLRequest(for: type, configuration: configuration)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            do {
                return try decode(data)
            } catch let error {
                throw APIError.decoding(error)
            }
        } catch let error {
            throw APIError.other(error)
        }
    }

    private func decode<Model: Decodable>(_ data: Data) throws -> Model {
        return try configuration.decoder.decode(Model.self, from: data)
    }
}
