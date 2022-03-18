//
//  SectorHeader.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import SwiftUI
import SSUtils
import Shared

struct SectorHeader: View {
    @Environment(\.editMode) private var editMode

    private let title: String
    private let editAction: Action?

    init(_ title: String, onEdit editAction: Action? = nil) {
        self.title = title
        self.editAction = editAction
    }

    var body: some View {
        HStack {
            Text(title, style: .headlineSmall)
            Spacer()
            if isEditing, let editAction = editAction {
                Button("Edit group", action: editAction)
                    .textStyle(.headlineSmallAction)
                    .padding(.horizontal, .small)
            }
        }
        .padding(.leading, .small)
        .padding(.bottom, .small)
    }

    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
}

// MARK: - Preview

struct SectorHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorHeader("Title")
            SectorHeader("Title").environment(\.editMode, .constant(.active))
        }
        .previewLayout(.sizeThatFits)
    }
}
