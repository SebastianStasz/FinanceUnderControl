//
//  PopupPresenter.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI

private struct PopupPresenter: ViewModifier {

    let popupModel: PopupModel?

    func body(content: Content) -> some View {
        ZStack {
            content

            if let popupModel = popupModel {
                popupBackground

                popupModel
                    .offset(x: 0, y: -50)
            }
        }
    }

    private var popupBackground: some View {
        Color.black.opacity(0.2).ignoresSafeArea(.all)
    }
}

extension View {
    func popup(_ popupModel: PopupModel?) -> some View {
        modifier(PopupPresenter(popupModel: popupModel))
    }
}
