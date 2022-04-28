//
//  RegisterPasswordHintVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Foundation
import Shared

struct RegisterPasswordHintVD {
    let isUpperAndLowerCharacter: Bool
    let isEightCharactersLong: Bool
    let isSpecialCharacter: Bool
    let isNumber: Bool

    init(for password: String) {
        isUpperAndLowerCharacter = password.fulfil(.containsUpperAndLowerCharacter)
        isSpecialCharacter = password.fulfil(.containsSpecialCharacter)
        isNumber = password.fulfil(.containsNumber)
        isEightCharactersLong = password.count >= 8
    }

    var isValid: Bool {
        isUpperAndLowerCharacter && isEightCharactersLong && isSpecialCharacter && isNumber
    }
}
