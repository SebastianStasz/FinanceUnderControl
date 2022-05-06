//
//  CashFlowCategoryGroup.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation
import FirebaseFirestore
import FinanceCoreData
import Shared

struct CashFlowCategoryGroup: FirestoreDocument {
    let id: String
    let name: String
    let type: CashFlowType
    let color: CashFlowCategoryColor
    let categories: [CashFlowCategory]

    enum Field: String, DocumentField {
        case id, name, type, color, categories
    }

    var data: [String: Any] {
        [Field.id.key: id,
         Field.name.key: name,
         Field.type.key: type,
         Field.color.key: color,
         Field.categories.key: categories.map { $0.id }]
    }
}

extension CashFlowCategoryGroup {
    init(from document: QueryDocumentSnapshot, categories: [CashFlowCategory]) {
        id = document.getString(for: Field.id)
        name = document.getString(for: Field.name)
        type = CashFlowType(rawValue: document.getString(for: Field.type))!
        color = CashFlowCategoryColor(rawValue: document.getString(for: Field.color)) ?? .red
        self.categories = categories
    }
}
