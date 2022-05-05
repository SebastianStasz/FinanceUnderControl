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

struct CashFlowCategory: FirestoreDocument, Identifiable, Equatable {
    let id: String
    let name: String
    let type: CashFlowType
    let icon: CashFlowCategoryIcon

    var data: [String: Any] {
        [Field.id.key: id,
         Field.name.key: name,
         Field.type.key: type,
         Field.icon.key: icon]
    }

    enum Field: String, DocumentField {
        case id, name, type, icon
    }
}

extension CashFlowCategory {
    init(from document: QueryDocumentSnapshot) {
        id = document.getString(for: Field.id)
        name = document.getString(for: Field.name)
        type = CashFlowType(rawValue: document.getString(for: Field.type))!
        icon = CashFlowCategoryIcon(rawValue: document.getString(for: Field.icon)) ?? .bagFill
    }
}

extension CashFlowCategory: Pickerable {
    var valueName: String { name }
}
