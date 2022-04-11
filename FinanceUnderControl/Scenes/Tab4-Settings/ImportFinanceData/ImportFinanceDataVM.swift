//
//  ImportFinanceDataVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/04/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSUtils

final class ImportFinanceDataVM: ViewModel {

    struct Input {
        let didSelectFile = DriverSubject<Result<URL, Error>>()
    }

    let input = Input()
    @Published private(set) var selectedFile: String?

    override init() {
        super.init()

        let selectedFile = PassthroughSubject<URL, Never>()
        let errorTracker = PassthroughSubject<Error, Never>()

        input.didSelectFile
            .sink { result in
                switch result {
                case let .success(url):
                    selectedFile.send(url)
                case let .failure(error):
                    errorTracker.send(error)
                }
            }
            .store(in: &cancellables)

        selectedFile
            .handleEvents(receiveOutput: { [weak self] in
                self?.selectedFile = $0.lastPathComponent
            })
            .await { url -> FinanceStorageModel in
                try await FileHelper.getModelFrom(url)
            }
            .stopLoading(on: self)
            .sink { completion in
                print(completion)
            } receiveValue: { financeStorageModel in
                print(financeStorageModel)
            }
            .store(in: &cancellables)
    }
}
