//
//  Publisher+Ext.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 06/04/2022.
//

import Combine
import Foundation
import SSUtils

extension Publisher {

    func startLoading<T: ViewModel>(on object: T?) -> AnyPublisher<Output, Failure> {
        setLoading(to: true, on: object)
    }

    func stopLoading<T: ViewModel>(on object: T?) -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.main)
            .setLoading(to: false, on: object)
            .handleEvents(receiveCompletion: { [weak object] _ in
                object?.isLoading = false
            })
            .eraseToAnyPublisher()
    }

    private func setLoading<T: ViewModel>(to isLoading: Bool, on object: T?) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { [weak object] _ in
            object?[keyPath: \.isLoading] = isLoading
        })
        .eraseToAnyPublisher()
    }

    func perform<T>(
        errorTracker: DriverSubject<Error>? = nil,
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Publishers.SetFailureType<AnyPublisher<T, Never>, Never>, Self> {
        flatMap {
            Just($0)
                .await(transform)
                .catch { error -> AnyPublisher<T, Never> in
                    errorTracker?.send(error)
                    Swift.print("-----")
                    Swift.print("‼️ \(error)")
                    Swift.print("-----")
                    return Just(nil).compactMap { $0 }.eraseToAnyPublisher()
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}


extension Publisher where Failure == Never {

    func sinkAndStore<VM: CombineHelper>(on viewModel: VM, action: @escaping (VM, Output) -> Void) {
        sink { [weak viewModel] value in
            guard let viewModel = viewModel else { return }
            action(viewModel, value)
        }
        .store(in: &viewModel.cancellables)
    }

    func performWithLoading<T, VM: ViewModel>(
        on viewModel: VM,
        errorTracker: DriverSubject<Error>? = nil,
        _ transform: @escaping (Output) async throws -> T
    ) -> AnyPublisher<T, Never> {
        startLoading(on: viewModel)
            .perform(errorTracker: errorTracker, transform)
            .stopLoading(on: viewModel)
            .eraseToAnyPublisher()
    }
}
