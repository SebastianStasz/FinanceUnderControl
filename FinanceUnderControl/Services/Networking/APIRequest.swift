//
//  APIRequest.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import Foundation
import SSUtils

protocol APIRequest {
    var path: String { get }
    var body: Encodable? { get }
    var method: RequestMethod { get }
    var headers: [String: String] { get }
    var queryParams: [String: String] { get }
}

extension APIRequest {
    var body: Encodable? { nil }
    var headers: [String: String] { [:] }
    var queryParams: [String: String] { [:] }
}

extension APIRequest {
    func getURLRequest(for type: RequestType, configuration: APIConfigurationProtocol) -> URLRequest {
        let baseURL = type.baseURL.appendingPathComponent(path)
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!

        if queryParams.isNotEmpty {
            components.queryItems = queryParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.addHTTPHeaders(headers)

        if let body = body {
            guard let data = try? body.encoded(using: configuration.encoder) else {
                assertionFailure("Failed to encode \(body)")
                return request
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
        }
        return request
    }
}
