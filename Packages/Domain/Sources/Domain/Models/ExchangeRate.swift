//
//  ExchangeRate.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import Foundation

public struct ExchangeRate {
    public let code: String
    public let rate: Double
}

extension ExchangeRate: Equatable {}
