//
//  ExportCashFlowDataVM.swift
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

final class ExportCashFlowDataVM: ViewModel {

    struct Input {
        let didTapExport = DriverSubject<Void>()
    }

    let fileNameInput = TextInputVM(validator: .alwaysValid())
    let defaultFileName: String
    let input = Input()
    @Published var activityAction: ActivityAction?
    @Published private(set) var financeStorage: FinanceStorageModel?

    init(controller: PersistenceController = AppVM.shared.controller) {
        defaultFileName = "Finance Under Control - \(Date().string(format: .medium))"
        super.init()

        input.didTapExport.first()
            .startLoading(on: self)
            .asyncMap { await FinanceStorageModel.generate(from: controller) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$financeStorage)

        CombineLatest(input.didTapExport, $financeStorage)
            .compactMap { $0.1 }
            .await { try await $0.toJsonString()}
            .map { FinanceStorageModel.toActivityAction($0) }
            .stopLoading(on: self)
            .sink { completion in
                if case .failure(let error) = completion {
                  print(error)
                }
            } receiveValue: { [weak self] activityAction in
                self?.activityAction = activityAction
            }
            .store(in: &cancellables)
    }
}
