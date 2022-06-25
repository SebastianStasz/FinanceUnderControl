//
//  PreciousMetalFormType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Foundation
import Shared

enum PreciousMetalFormType {
    case new(PreciousMetalType? = nil)
    case edit(PreciousMetal)

    var title: String {
        switch self {
        case .new:
            return .precious_metal_form_add_metal_title
        case .edit:
            return .precious_metal_form_edit_metal_title
        }
    }

    var isEdit: Bool {
        if case .edit = self { return true }
        return false
    }
}
