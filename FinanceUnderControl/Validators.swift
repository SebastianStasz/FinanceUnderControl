//
//  Validators.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/03/2022.
//

import Foundation
import SSValidation

extension Validator where Source == String {

    static func name(withoutRepeating namesInUse: [String] = []) -> Validator {
        notEmpty().and(.lengthBetween(3...40)).and(.isNotEqual(to: namesInUse, errorMessage: "Element with this name already exists."))
    }

    static func money() -> Validator {
        notEmpty().andDouble(.notLessThan(0.01))
    }
}
