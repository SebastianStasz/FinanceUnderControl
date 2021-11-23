//
//  ExchangeRate.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import Foundation

public struct ExchangeRate {
    let code: String
    let rate: Double
}

extension ExchangeRate: Equatable {}
