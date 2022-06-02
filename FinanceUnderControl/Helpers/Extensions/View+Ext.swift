//
//  View+Ext.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/04/2022.
//

import Shared
import SwiftUI

extension View {
    func actions(edit: @autoclosure @escaping Action, delete: @autoclosure @escaping Action) -> some View {
        self
            .contextMenu {
                Button.edit(action: edit)
                Button.delete(action: delete)
            }
            .swipeActions {
                Button.delete(action: delete)
                Button.edit(action: edit)
            }
    }

    func closeButton(action: @escaping Action) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(systemImage: SFSymbol.close.rawValue, action: action)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}
