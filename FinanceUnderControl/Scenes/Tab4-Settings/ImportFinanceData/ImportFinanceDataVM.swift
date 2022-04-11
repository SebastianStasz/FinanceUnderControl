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
        let didEnterCustomizeView = DriverSubject<Void>()
        let didConfirmImporting = DriverSubject<Void>()
    }

    let input = Input()
    @Published private(set) var selectedFile: URL?
    @Published private(set) var importResult: FinanceStorage.ImportResult?

    init(controller: PersistenceController = AppVM.shared.controller) {
        super.init()

        let errorTracker = PassthroughSubject<Error, Never>()

        input.didSelectFile
            .sink { [weak self] result in
                switch result {
                case let .success(url):
                    self?.selectedFile = url
                case let .failure(error):
                    errorTracker.send(error)
                }
            }
            .store(in: &cancellables)

        CombineLatest(input.didEnterCustomizeView, $selectedFile)
            .compactMap { $0.1 }
            .removeDuplicates()
            .startLoading(on: self)
            .await { url -> FinanceStorage.ImportResult in
                let storage: FinanceStorage = try await FileHelper.getModelFrom(url)
                return await storage.getImportResult(for: controller)
            }
            .stopLoading(on: self)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] importResult in
                self?.importResult = importResult
            }
            .store(in: &cancellables)

        CombineLatest(input.didConfirmImporting, $importResult)
            .compactMap { $0.1 }
            .startLoading(on: self)
            .await { importResult in
                
            }
    }
}
