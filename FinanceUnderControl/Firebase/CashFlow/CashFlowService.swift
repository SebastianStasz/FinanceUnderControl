//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Combine
import Foundation
import FirebaseFirestore
import SSUtils

final class CashFlowService: CollectionService {
    typealias Document = CashFlow

    private let firestore = FirestoreService.shared
    private let walletService = WalletService.shared
    private let categoryService = CashFlowCategoryService()

    func create(_ cashFlow: CashFlow) async throws {
        var batch = firestore.batch
        batch = walletService.updateBalance(for: .new(cashFlow), using: batch)
        batch = firestore.create(withId: cashFlow.id, in: .cashFlows, data: cashFlow.data, batch: batch)
        try await batch.commit()
    }

    func edit(_ cashFlow: CashFlow, oldValue: Decimal) async throws {
        var batch = firestore.batch
        batch = walletService.updateBalance(for: .edit(cashFlow, oldValue: oldValue), using: batch)
        batch = firestore.edit(withId: cashFlow.id, in: .cashFlows, data: cashFlow.data, batch: batch)
        try await batch.commit()
    }

    func delete(_ cashFlow: CashFlow) async throws {
        var batch = firestore.batch
        batch = walletService.updateBalance(for: .delete(cashFlow), using: batch)
        batch = firestore.deleteDocument(withId: cashFlow.id, from: .cashFlows, batch: batch)
        try await batch.commit()
    }
}
