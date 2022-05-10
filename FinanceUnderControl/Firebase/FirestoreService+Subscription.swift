//
//  FirestoreService+Subscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/05/2022.
//

import Combine
import Foundation

extension FirestoreService {
    struct Subscription<T> {
        let output: AnyPublisher<T, Never>
        let error: AnyPublisher<Error, Never>
    }
}
