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

struct CashFlowCategoryGroup: FirestoreDocument, Hashable {
    let id: String
    let name: String
    let type: CashFlowType
    let color: CashFlowCategoryColor

    enum Field: String, DocumentField {
        case id, name, type, color
    }

    var data: [String: Any] {
        [Field.id.key: id,
         Field.name.key: name,
         Field.type.key: type.rawValue,
         Field.color.key: color.rawValue]
    }

    var formModel: CashFlowCategoryGroupFormModel {
        .init(name: name, color: color)
    }
}

extension CashFlowCategoryGroup {
    init(from document: QueryDocumentSnapshot) {
        id = document.getString(for: Field.id)
        name = document.getString(for: Field.name)
        type = CashFlowType(rawValue: document.getString(for: Field.type))!
        color = CashFlowCategoryColor(rawValue: document.getString(for: Field.color)) ?? .red
    }
}
