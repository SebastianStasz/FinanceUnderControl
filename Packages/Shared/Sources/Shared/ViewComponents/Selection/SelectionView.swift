//
//  SelectionView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

struct SelectionView: View {
    let type: SelectionType
    let isOn: Bool
    let action: Action

    var body: some View {
        Button(action: action) {
            if isOn {
                type.selectedImage
                    .foregroundColor(.green)
            } else {
                type.unselectedImage
                    .opacity(0.5)
            }
        }
        .buttonStyle(.plain)
    }
}
