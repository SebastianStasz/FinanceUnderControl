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

    func onNext(_ perform: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { perform($0) }).eraseToAnyPublisher()
    }

    func map<O: AnyObject, T>(on object: O, transform: @escaping (O, Output) -> T) -> AnyPublisher<T, Failure> {
        compactMap { [weak object] in
            guard let object = object else { return nil }
            return transform(object, $0)
        }
        .eraseToAnyPublisher()
    }

    func onNext<T: AnyObject>(on object: T, perform: @escaping (T, Output) -> Void) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput:  { [weak object] output in
            guard let object = object else { return }
            perform(object, output)
        })
        .eraseToAnyPublisher()
    }

    func perform<T>(
        isLoading: DriverSubject<Bool>? = nil,
        errorTracker: DriverSubject<Error>? = nil,
        _ perform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Publishers.SetFailureType<AnyPublisher<T, Never>, Never>, Self> {
        flatMap {
            Just($0)
                .onNext { _ in isLoading?.send(true) }
                .await(perform)
                .catch(isLoading: isLoading, errorTracker: errorTracker)
                .receive(on: DispatchQueue.main)
                .onNext { _ in isLoading?.send(false) }
                .eraseToAnyPublisher()
        }
    }

    func perform<O: AnyObject, T>(
        on object: O,
        isLoading: DriverSubject<Bool>? = nil,
        errorTracker: DriverSubject<Error>? = nil,
        _ perform: @escaping (O, Output) async throws -> T
    ) -> Publishers.FlatMap<Publishers.SetFailureType<AnyPublisher<T, Never>, Never>, Self> {
        flatMap {
            Just($0)
                .onNext { _ in isLoading?.send(true) }
                .await(on: object, perform: perform)
                .catch(isLoading: isLoading, errorTracker: errorTracker)
                .receive(on: DispatchQueue.main)
                .onNext { _ in isLoading?.send(false) }
                .eraseToAnyPublisher()
        }
    }

    private func `catch`(isLoading: DriverSubject<Bool>?, errorTracker: DriverSubject<Error>? = nil) -> AnyPublisher<Output, Never> {
        `catch` { error -> AnyPublisher<Output, Never> in
            DispatchQueue.main.async {
                errorTracker?.send(error)
                isLoading?.send(false)
            }
            Swift.print("-----")
            Swift.print("‼️ \(error)")
            Swift.print("-----")
            return Just(nil).compactMap { $0 }.eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
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
}
