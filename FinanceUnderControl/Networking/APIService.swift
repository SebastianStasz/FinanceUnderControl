//
//  APIService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import Combine
import Domain
import Foundation
import SSUtils

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

    func execute<Model: Decodable>(_ apiRequest: APIRequest, type: RequestType) async throws -> Model {
        let request = apiRequest.getURLRequest(for: type, configuration: configuration)
        printDebug(for: request)
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

    private func printDebug(for request: URLRequest) {
        let method = request.httpMethod ?? "Unknown httpMethod"
        let url = request.url?.absoluteString ?? "Unknown URL"
        let requestInfo = "\n⬆️ \(method) -> \(url)"
        let separators = Array(repeating: "-", count: requestInfo.count).joined()
        print(requestInfo)
        print(separators)
    }

    private func decode<Model: Decodable>(_ data: Data) throws -> Model {
        return try configuration.decoder.decode(Model.self, from: data)
    }
}
