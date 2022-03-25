//
//  SelectionType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

enum SelectionType {
    case radio
    case checkbox

    var selectedImage: Image {
        switch self {
        case .radio:
            return SFSymbol.radioChecked.image
        case .checkbox:
            return SFSymbol.checkboxChecked.image
        }
    }

    var unselectedImage: Image {
        switch self {
        case .radio:
            return SFSymbol.radioUnchecked.image
        case .checkbox:
            return SFSymbol.checkboxUnchecked.image
        }
    }
}
