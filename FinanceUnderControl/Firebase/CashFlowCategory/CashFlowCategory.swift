//
//  CashFlowCategory.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import FirebaseFirestore
import Foundation
import Shared

struct CashFlowCategory: FirestoreDocument {
    let id: String
    let name: String
    let type: CashFlowType
    let icon: CashFlowCategoryIcon
    let group: CashFlowCategoryGroup?

    enum Field: String, DocumentField {
        case id, name, type, icon, groupId
    }

    var data: [String: Any] {
        [Field.id.key: id,
         Field.name.key: name,
         Field.type.key: type.rawValue,
         Field.icon.key: icon.rawValue,
         Field.groupId.key: group?.id as Any]
    }
}

extension CashFlowCategory {
    init(from document: QueryDocumentSnapshot, group: CashFlowCategoryGroup?) {
        id = document.getString(for: Field.id)
        name = document.getString(for: Field.name)
        type = CashFlowType(rawValue: document.getString(for: Field.type))!
        icon = CashFlowCategoryIcon(rawValue: document.getString(for: Field.icon)) ?? .bagFill
        self.group = group
    }
}

extension CashFlowCategory: Pickerable {
    var valueName: String { name }
}
