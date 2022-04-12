//
//  Publisher+Ext.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 06/04/2022.
//

import Combine
import Foundation

extension Publisher {

    func startLoading<T: ViewModel>(on object: T) -> AnyPublisher<Output, Failure> {
        setLoading(to: true, on: object)
    }

    func stopLoading<T: ViewModel>(on object: T) -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.main)
            .setLoading(to: false, on: object)
            .handleEvents(receiveCompletion: { [weak object] _ in
                object?.isLoading = false
            })
            .eraseToAnyPublisher()
    }

    private func setLoading<T: ViewModel>(to isLoading: Bool, on object: T) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { [weak object] _ in
            object?[keyPath: \.isLoading] = isLoading
        })
        .eraseToAnyPublisher()
    }
}
