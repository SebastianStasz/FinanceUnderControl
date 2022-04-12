//
//  ExportFinanceDataVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/04/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSUtils
import SSValidation

final class ExportFinanceDataVM: ViewModel {

    struct Input {
        let didTapExport = DriverSubject<Void>()
        let exportResult = DriverSubject<Result<URL, Error>>()
    }

    @Published var financeDataFile: FinanceDataFile?
    @Published var isExporterShown = false
    @Published var errorMessage: String?

    let fileNameInput = TextInputVM(validator: .alwaysValid())
    let defaultFileName: String
    let input = Input()

    init(controller: PersistenceController = AppVM.shared.controller) {
        let defaultFileName = Self.defaultFileName
        self.defaultFileName = defaultFileName
        super.init()

        let fetchFinanceData = input.didTapExport.first()
            .startLoading(on: self)
            .asyncMap { await FinanceData(from: controller) }
            .stopLoading(on: self)

        let financeData = fetchFinanceData
            .filter { $0.isNotEmpty }.map { $0 }

        let fileName = fileNameInput.result()
            .map { $0 ?? defaultFileName }

        let financeDataFile = CombineLatest(financeData, fileName)
            .map { FinanceDataFile(data: $0.0, fileName: $0.1) }

        let exportTrigger = Publishers.Merge(
            input.didTapExport.withLatestFrom(financeDataFile),
            CombineLatest(input.didTapExport, financeDataFile).map { $0.1 }.first()
        )

        exportTrigger
            .sink { [weak self] in
                self?.financeDataFile = $0
                self?.isExporterShown = true
            }
            .store(in: &cancellables)

        fetchFinanceData
            .filter { $0.isEmpty }
            .map { _ in "There is no finance data." }
            .assign(to: &$errorMessage)

        input.exportResult
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.baseAction.dismissView.send()
                    print("Success")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
            .store(in: &cancellables)
    }

    static private var defaultFileName: String {
        "Finance Under Control - \(Date().string(format: .medium))".replacingOccurrences(of: "/", with: ".")
    }
}
