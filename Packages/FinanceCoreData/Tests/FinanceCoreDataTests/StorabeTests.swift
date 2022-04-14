//
//  StorableTests.swift
//  FinanceCoreDataTests
//
//  Created by sebastianstaszczyk on 09/04/2022.
//

import CoreData
import XCTest
@testable import FinanceCoreData

final class StorableTests: XCTestCase {

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }
//
//    func test_finance_store_model_generate() {
//        // Given: Cash flow category groups exists.
//        let workIncomeGroup = CashFlowCategoryGroupEntity.createAndReturn(in: context, model: .init(name: "Work", type: .income))
//        let investmentsIncomeGroup = CashFlowCategoryGroupEntity.createAndReturn(in: context, model: .init(name: "Investments", type: .income))
//        let hobbyExpenseGroup = CashFlowCategoryGroupEntity.createAndReturn(in: context, model: .init(name: "Hobby", type: .expense))
//
//        // Given: Cash flow categories exists.
//        let paymentIncomeCategory = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Payment", icon: .banknoteFill, color: .green, type: .income))
//        workIncomeGroup.addToCategories(paymentIncomeCategory)
//
//        let cryptoIncomeCategory = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Crypto", icon: .cloudFill, color: .mint, type: .income))
//        investmentsIncomeGroup.addToCategories(cryptoIncomeCategory)
//    }
}
