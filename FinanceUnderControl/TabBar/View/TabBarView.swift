//
//  TabBarView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import SwiftUI
import Shared

struct TabBarView: View {

    @ObservedObject var viewModel: TabBarVM

    var body: some View {
        HStack {
            ForEach(TabBarModel.allCases) { tab in
                if isMiddleElement(tab.id) {
                    TabBarActionButton(viewModel: viewModel).offset(y: -14)
                }

                Button(tab.name, action: selectTab(tab))
                    .buttonStyle(TabBarButtonStyle(for: tab, isSelected: viewModel.selectedTab == tab))
            }
        }
        .infiniteWidth(maxHeight: 49)
        .background(tabBarBackground)
    }

    private var tabBarBackground: some View {
        Color.backgroundSecondary
            .cornerRadius(15)
            .edgesIgnoringSafeArea(.bottom)
            .shadow(color: .black.opacity(0.05), radius: 5)
    }

    // MARK: Interactions

    private func isMiddleElement(_ element: Int) -> Bool {
        element == TabBarModel.allCases.count / 2
    }

    private func selectTab(_ tab: TabBarModel) {
        viewModel.binding.didSelectTab.send(tab)
    }
}

// MARK: - Preview

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TabBarVM(coordinator: PreviewCoordinator())
        TabBarView(viewModel: viewModel)
        TabBarView(viewModel: viewModel).darkScheme()
    }
}
