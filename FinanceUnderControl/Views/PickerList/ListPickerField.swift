//
//  ListPickerField.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import Shared
import SwiftUI

struct ListPickerField: View {

    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
}


// MARK: - Preview

struct ListPickerField_Previews: PreviewProvider {
    static var previews: some View {
        ListPickerField(title: "Label", value: "Value")
    }
}
