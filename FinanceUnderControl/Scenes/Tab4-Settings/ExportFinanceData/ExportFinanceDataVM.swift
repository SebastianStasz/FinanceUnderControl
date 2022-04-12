//
//  ExportFinanceDataVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/04/2022.
//

import Combine
import FinanceCoreData
import Foundation
import UIKit
import SSUtils
import SSValidation

final class ExportFinanceDataVM: ViewModel {

    struct Input {
        let didTapExport = DriverSubject<Void>()
    }

    @Published private(set) var financeData: FinanceData?
    @Published var activityAction: ActivityAction?
    @Published var errorMessage: String?

    let fileNameInput = TextInputVM(validator: .alwaysValid())
    let defaultFileName: String
    let input = Input()

    init(controller: PersistenceController = AppVM.shared.controller) {
        let defaultFileName = Self.defaultFileName
        self.defaultFileName = defaultFileName
        super.init()

        let errorTracker = PassthroughSubject<Error, Never>()

        let financeData = input.didTapExport.first()
            .startLoading(on: self)
            .asyncMap { await FinanceData(from: controller) }
            .stopLoading(on: self)

        financeData
            .filter { $0.isEmpty }
            .map { _ in "There is no finance data." }
            .assign(to: &$errorMessage)

        financeData
            .filter { $0.isNotEmpty }
            .map { $0 }
            .assign(to: &$financeData)

        CombineLatest(input.didTapExport, $financeData)
            .compactMap { $0.1 }
            .startLoading(on: self)
            .flatMap {
                Just($0)
                    .await { try await FileHelper.toJsonString($0) }
                    .tryMap { [weak self] in
                        let fileName = self?.fileNameInput.resultValue ?? defaultFileName
                        return try FileHelper.getTemporaryURL(forContent: $0, fileName: fileName, fileExtension: .json)
                    }
                    .map { ActivityAction(items: $0 as Any, excludedTypes: Self.excludedTypes) }
                    .stopLoading(on: self)
                    .catch { error -> AnyPublisher<ActivityAction?, Never> in
                        errorTracker.send(error)
                        return Just(nil).compactMap { $0 }.eraseToAnyPublisher()
                    }
            }
            .assign(to: &$activityAction)

        errorTracker
            .sink { error in
                print(error)
            }
            .store(in: &cancellables)
    }

    static var defaultFileName: String {
        "Finance Under Control - \(Date().string(format: .medium))".replacingOccurrences(of: "/", with: ".")
    }

    static var excludedTypes: [UIActivity.ActivityType] {
        [.addToReadingList, .assignToContact, .openInIBooks]
    }
}
