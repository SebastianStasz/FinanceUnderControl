//
//  ValidationHelper.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 03/12/2021.
//

import Combine
import Foundation

struct ValidationHelper {

    static func search(_ text: Published<String>.Publisher) -> AnyPublisher<String, Never> {
        text
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .lowerCaseDiacriticInsensitive()
    }

    static func search(_ text: String) -> String {
        text.lowerCaseDiacriticInsensitive
    }
}
