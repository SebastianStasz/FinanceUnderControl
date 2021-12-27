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
        if isPresented {
            content.overlay(popup())
        } else {
            content
        }
    }
}

extension View {
    func popup<Popup: View>(isPresented: Bool, popup: @escaping () -> Popup) -> some View {
        modifier(PopupPresenter(isPresented: isPresented, popup: popup))
    }
}
