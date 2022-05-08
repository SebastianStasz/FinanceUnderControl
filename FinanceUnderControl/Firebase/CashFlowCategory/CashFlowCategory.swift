//
//  CashFlowCategory.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import FinanceCoreData
import FirebaseFirestore
import Foundation
import Shared

struct CashFlowCategory: FirestoreDocument {
    let id: String
    let name: String
    let type: CashFlowType
    let icon: CashFlowCategoryIcon
    let groupId: String?

    enum Field: String, DocumentField {
        case id, name, type, icon, groupId
    }

    var data: [String: Any] {
        [Field.id.key: id,
         Field.name.key: name,
         Field.type.key: type,
         Field.icon.key: icon,
         Field.groupId.key: groupId as Any]
    }
}

extension CashFlowCategory {
    init(from document: QueryDocumentSnapshot) {
        id = document.getString(for: Field.id)
        name = document.getString(for: Field.name)
        type = CashFlowType(rawValue: document.getString(for: Field.type))!
        icon = CashFlowCategoryIcon(rawValue: document.getString(for: Field.icon)) ?? .bagFill
        groupId = document.get(Field.groupId) as? String
    }
}

extension CashFlowCategory: Pickerable {
    var valueName: String { name }
}
