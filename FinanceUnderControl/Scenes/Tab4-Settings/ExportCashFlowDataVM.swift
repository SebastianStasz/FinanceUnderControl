//
//  ExportCashFlowDataVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/04/2022.
//

import Combine
import Foundation
import SSUtils
import SSValidation

final class ExportCashFlowDataVM: ViewModel {

    struct Input {
        let didTapExport = DriverSubject<Void>()
    }

    let fileNameInput = TextInputVM(validator: .alwaysValid())
    let defaultFileName: String
    let input = Input()
    @Published var activityItem: ActivityAction?

    override init() {
        defaultFileName = "Finance Under Control - \(Date().string(format: .medium))"
        super.init()

        let cashFlowData = input.didTapExport.first()
            .startLoading(on: self)
            .asyncMap { [weak self] in await self?.samplePrepareData() }
            .stopLoading(on: self)

        CombineLatest(input.didTapExport, cashFlowData)
            .map { ActivityAction(items: $0.1 as Any) }
            .assign(to: &$activityItem)
    }

    private func samplePrepareData() async -> String {
        try! await Task.sleep(nanoseconds: 3000000000)
        return "Prepare cash flow data here"
    }
}
