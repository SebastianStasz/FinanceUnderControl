//
//  APIError.swift
//  Domain
//
//  Created by sebastianstaszczyk on 28/03/2022.
//

import Foundation

public enum APIError: Error {
    case other(Error)
    case decoding(Error)
    case unknown
}
