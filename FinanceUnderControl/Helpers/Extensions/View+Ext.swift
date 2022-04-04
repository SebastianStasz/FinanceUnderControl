//
//  View+Ext.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/04/2022.
//

import SwiftUI

extension View {
    func actions(edit: @autoclosure @escaping Action, delete: @autoclosure @escaping Action) -> some View {
        self
            .contextMenu {
                Button.edit(edit)
                Button.delete(delete)
            }
            .swipeActions {
                Button.delete(delete)
                Button.edit(edit)
            }
    }
}
