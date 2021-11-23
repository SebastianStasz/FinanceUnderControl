//
//  TabBarView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import SwiftUI
import Shared
import SSUtils

struct TabBarView: View {

    @ObservedObject var viewModel: TabBarVM

    var body: some View {
        VStack(spacing: 0) {
            // TabView
            TabView(selection: $viewModel.selectedTab ) {
                ForEach(viewModel.availableTabs) { tab in
                    tab.embedInNavigationView(title: tab.name).tag(tab)
                }
            }

            // TabBar
            HStack(spacing: 0) {
                ForEach(viewModel.availableTabs) { tab in
                    if isMiddleElement(tab.id) { buttonShowAddingButtons }
                    buttonSwitchToTab(tab)
                }
            }
            .infiniteWidth(maxHeight: 49)
            .background(tabBarBackground)
        }
        .background(Color.backgroundMain)
    }

    // MARK: View Components

    private var tabBarBackground: some View {
        Color.backgroundSecondary
            .cornerRadius(15)
            .edgesIgnoringSafeArea(.bottom)
            .shadow(color: .black.opacity(0.05), radius: 5)
    }

    // MARK: Interactions

    private var buttonShowAddingButtons: some View {
        TabBarActionButton(viewModel: viewModel).offset(y: -14)
    }

    private func buttonSwitchToTab(_ tab: TabBarModel) -> some View {
        Button(tab.name, action: viewModel.navigate(to: .tab(tab)))
            .buttonStyle(TabBarButtonStyle(for: tab, isSelected: isTabSelected(tab)))
    }

    // MARK: Helpers

    private func isTabSelected(_ tab: TabBarModel) -> Bool {
        viewModel.selectedTab == tab
    }

    private func isMiddleElement(_ element: Int) -> Bool {
        element == viewModel.availableTabs.count / 2
    }
}


// MARK: - Preview

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: TabBarVM())
    }
}