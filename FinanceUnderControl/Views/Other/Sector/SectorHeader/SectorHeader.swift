//
//  SectorHeader.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import Shared
import SSUtils
import SwiftUI

struct SectorHeader: View {
    @Environment(\.editMode) private var editMode
    private let viewData: SectorHeaderVD

    var body: some View {
        HStack {
            Text(viewData.title, style: .headlineSmall)
            Spacer()
            if let editAction = viewData.editAction, isEditing {
                Button(editAction.title, action: editAction.action)
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

    // MARK: - Initializers

    init(_ viewData: SectorHeaderVD) {
        self.viewData = viewData
    }

    init?(_ viewData: SectorHeaderVD?) {
        guard let viewData = viewData else { return nil }
        self.viewData = viewData
    }
}

// MARK: - Preview

struct SectorHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorHeader(.init("Title"))
            SectorHeader(.init("Title")).environment(\.editMode, .constant(.active))
        }
        .previewLayout(.sizeThatFits)
    }
}
