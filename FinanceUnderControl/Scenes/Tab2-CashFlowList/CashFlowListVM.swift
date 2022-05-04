//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSUtils
import SSValidation

final class CashFlowListVM: ViewModel {
    typealias Filter = CashFlowEntity.Filter

    private let service: CashFlowService

    let minValueInput = DoubleInputVM(validator: .alwaysValid)
    let maxValueInput = DoubleInputVM(validator: .alwaysValid)

    @Published private(set ) var cashFlowPredicate: NSPredicate?
    @Published var cashFlowFilter = CashFlowFilter()
    @Published var searchText = ""

    init(coordinator: CoordinatorProtocol, service: CashFlowService = .init()) {
        self.service = service
        super.init(coordinator: coordinator)

//        let searchPredicate = $searchText
//            .map { $0.isEmpty ? nil : Filter.nameContains($0).nsPredicate }
//
//        CombineLatest(searchPredicate, $cashFlowFilter)
//            .map { [$0, $1.nsPredicate].andNSPredicate }
//            .assign(to: &$cashFlowPredicate)
    }

    override func viewDidLoad() {
        let errorTracker = DriverSubject<Error>()

        minValueInput.assignResult(to: \.cashFlowFilter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.cashFlowFilter.maximumValue, on: self)

        Just(())
            .perform(on: self, errorTracker: errorTracker) { [weak self] in
                try await self?.service.fetchAll()
            }
            .sinkAndStore(on: self) { vm, _ in

            }
    }
}
