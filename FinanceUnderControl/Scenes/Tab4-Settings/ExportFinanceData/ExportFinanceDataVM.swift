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

    let fileNameInput = TextInputVM(validator: .alwaysValid())
    let defaultFileName: String
    let input = Input()
    @Published var activityAction: ActivityAction?
    @Published private(set) var financeStorage: FinanceStorage?

    init(controller: PersistenceController = AppVM.shared.controller) {
        let defaultFileName = "Finance Under Control - \(Date().string(format: .medium))".replacingOccurrences(of: "/", with: ".")
        self.defaultFileName = defaultFileName
        super.init()

        let errorTracker = PassthroughSubject<Error, Never>()

        input.didTapExport.first()
            .startLoading(on: self)
            .asyncMap { await FinanceStorage.generate(from: controller) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$financeStorage)

        CombineLatest(input.didTapExport, $financeStorage)
            .startLoading(on: self)
            .compactMap { $0.1 }
            .flatMap {
                Just($0)
                    .await { try await $0.toJsonString() }
                    .tryMap { try FileHelper.getTemporaryURL(forContent: $0, fileName: defaultFileName, fileExtension: .json) }
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

    static var excludedTypes: [UIActivity.ActivityType] {
        [.addToReadingList, .assignToContact, .openInIBooks]
    }
}
