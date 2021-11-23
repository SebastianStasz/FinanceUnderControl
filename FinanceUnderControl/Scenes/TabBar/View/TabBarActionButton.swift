//
//  TabBarActionButton.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

struct TabBarActionButton: View {
    typealias Popup = TabBarModel.Popup

    @ObservedObject var viewModel: TabBarVM

    // MARK: - View

    var body: some View {
        Button("Add", action: togglePopupButtons)
            .buttonStyle(TabBarActionButtonStyle(isEnabled: viewModel.arePopupsShown))
            .disableInteractions(settings: interactionBlockerSettings)
    }

    private var popupButtons: some View {
        Group {
            popupButton(Popup.first, angle: -65, action: {}())
            popupButton(Popup.second, angle: -115, action: {}())
        }
    }

    // MARK: Interactions

    private func togglePopupButtons() {
        viewModel.arePopupsShown.toggle()
    }

    private func popupButton(_ popup: Popup, angle: Double, action: @autoclosure @escaping () -> Void) -> some View {
        let offset = getOffset(for: angle)

        return Button(popup.title, action: action)
            .buttonStyle(TabBarPopupButtonStyle(image: popup.icon.name))
            .offset(x: offset.x, y: offset.y)
            .frame(width: 47, height: 47)
            .animation(.easeInOut(duration: 0.2))
    }

    // MARK: - Helpers

    private var interactionBlockerSettings: InteractionBlocker.Settings {
        .init(when: $viewModel.arePopupsShown, onTopShow: AnyView(popupButtons), closingDuration: 0.2, isParentViewInteractive: true)
    }

    private func getOffset(for angle: Double) -> (x: CGFloat, y: CGFloat) {
        let theta = CGFloat(.pi * angle / 180)
        let x = 210 / 2 * cos(theta)
        let y = 120 / 2 * sin(theta)

        return (x: viewModel.arePopupsShown ? x : 0, y: viewModel.arePopupsShown ? y : 0)
    }
}


// MARK: - Preview

struct TabBarAddButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundMain
            TabBarActionButton(viewModel: TabBarVM())
                .frame(width: 50, height: 50)
        }
    }
}