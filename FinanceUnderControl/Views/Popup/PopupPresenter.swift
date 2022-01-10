//
//  PopupPresenter.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI

private struct PopupPresenter<Popup: View>: ViewModifier {

    var isPresented: Bool
    var popup: () -> Popup

    func body(content: Content) -> some View {
        ZStack {
            content
                .overlay(Color.black.opacity(isPresented ? 0.2 : 0))
                .navigationBarBackButtonHidden(isPresented)
                .disabled(isPresented)

            if isPresented {
                popup()
                    .offset(x: 0, y: -50)
            }
        }
    }
}

extension View {
    func popup<Popup: View>(isPresented: Bool, popup: @escaping () -> Popup) -> some View {
        modifier(PopupPresenter(isPresented: isPresented, popup: popup))
    }
}
