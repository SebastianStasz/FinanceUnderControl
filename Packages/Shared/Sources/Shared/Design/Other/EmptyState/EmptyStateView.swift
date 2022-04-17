//
//  EmptyStateView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import SwiftUI
import SSUtils

struct EmptyStateView: View {

    private let viewData: EmptyStateVD

    init(_ viewData: EmptyStateVD) {
        self.viewData = viewData
    }

    var body: some View {
        VStack(alignment: .center, spacing: .xxlarge) {
            Image.emptyState1

            VStack(alignment: .center, spacing: .small) {
                Text(viewData.title, style: .headlineBig)

                Text(viewData.description, style: .body())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .xxlarge * 2)
            }
        }
        .padding(.bottom, 80)
        .infiniteSize()
    }
}

// MARK: - Preview

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        let viewData = EmptyStateVD(
            title: "No notifications yet",
            description: "We will notify you once we have sometinhg for you"
        )
        EmptyStateView(viewData)
        EmptyStateView(viewData).darkScheme()
    }
}

