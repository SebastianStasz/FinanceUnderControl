//
//  DesignSystemView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/06/2022.
//

import Shared
import SwiftUI

public struct DesignSystemView: View {

    @ObservedObject var viewModel: DesignSystemVM

    public var body: some View {
        FormView {
            Sector("Atoms") {
                Navigation("Text", action: navigate(to: .text))
                Navigation("Color", action: navigate(to: .color))
                Navigation("SF Symbol", action: navigate(to: .sfSymbol))
                Navigation("Spacing", action: navigate(to: .spacing))
                Navigation("Corner radius", action: navigate(to: .cornerRadius))
            }

            Sector("Form") {
                Navigation("Button", action: navigate(to: .button))
                Navigation("Toggle", action: navigate(to: .toggle))
                Navigation("Picker", action: navigate(to: .picker))
                Navigation("Text Field", action: navigate(to: .textField))
            }

            Sector("Other") {
                Navigation("Sector", action: navigate(to: .sector))
                Navigation("Circle view", action: navigate(to: .circleView))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func navigate(to destination: DesignSystemCoordinator.Destination) {
        viewModel.binding.navigateTo.send(destination)
    }
}

// MARK: - Preview

struct DesignSystemView_Previews: PreviewProvider {
    static var previews: some View {
        DesignSystemView(viewModel: .init())
        DesignSystemView(viewModel: .init()).darkScheme()
    }
}

