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
        let didConfirmImporting = DriverSubject<Void>()
    }

    let input = Input()
    @Published var importer: FinanceDataImporter?

    init(controller: PersistenceController = AppVM.shared.controller) {
        super.init()

        let errorTracker = DriverSubject<Error>()
        let selectedFile = DriverSubject<URL>()

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
            .startLoading(on: self)
            .await { try await FileHelper.getModelFrom($0) }
            .asyncMap { await FinanceDataImporter(from: controller, financeData: $0) }
            .stopLoading(on: self)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] in
                self?.importer = $0
            }
            .store(in: &cancellables)

        input.didConfirmImporting
            .compactMap { [weak self] in self?.importer }
            .startLoading(on: self)
            .asyncMap { await $0.create() }
            .stopLoading(on: self)
            .sink { print("success") }
            .store(in: &cancellables)
    }
}
