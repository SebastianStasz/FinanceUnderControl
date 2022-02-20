//
//  InteractionBlocker.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Combine
import SwiftUI
import UIKit

struct InteractionBlocker: ViewModifier {

    @State private var isOverlayVisible = false

    @Binding private var isInteractionBlocked: Bool
    private var interactiveView: AnyView
    private var closingDuration: Double
    private var isParentViewInteractive: Bool
    private var isDismissedOnOverlayTap: Bool
    private var onDismiss: (() -> Void)?

    fileprivate init(isInteractionBlocked: Binding<Bool>,
                     interactiveView: AnyView,
                     closingDuration: Double,
                     isParentViewInteractive: Bool,
                     isDismissedOnOverlayTap: Bool,
                     onDismiss: (() -> Void)?) {
        self._isInteractionBlocked = isInteractionBlocked
        self.interactiveView = interactiveView
        self.closingDuration = closingDuration
        self.isParentViewInteractive = isParentViewInteractive
        self.isDismissedOnOverlayTap = isDismissedOnOverlayTap
        self.onDismiss = onDismiss
    }

    // MARK: - View

    func body(content: Content) -> some View {
        ZStack {
            content
                .zIndex(isParentViewInteractive ? 2 : 0)

            interactiveView
                .opacity(isOverlayVisible ? 1 : 0)
                .zIndex(1)

            overlayView
                .opacity(isOverlayVisible ? 1 : 0)

                .onChange(of: isInteractionBlocked) { isBlocked in
                    if isBlocked { isOverlayVisible = true }
                    else { enableInteractions() }
                }
        }
        .zIndex(1)
    }

    private var overlayView: some View {
        Color.clear
            .frame(width: 5000, height: 5000)
            .contentShape(Rectangle())
            .onTapGesture { enableInteractionsIfAllowed() }
            .frame(maxWidth: 1, maxHeight: 1)
    }

    private func enableInteractionsIfAllowed() {
        guard isDismissedOnOverlayTap else { return }
        enableInteractions()
    }

    private func enableInteractions() {
        onDismiss?()
        isInteractionBlocked = false
        DispatchQueue.main.asyncAfter(deadline: .now() + closingDuration) {
            if !isInteractionBlocked { isOverlayVisible = false }
        }
    }
}

// MARK: - Settings Helper

extension InteractionBlocker {
    struct Settings {
        @Binding var isInteractionBlocked: Bool
        let interactiveView: AnyView
        let closingDuration: Double
        let isParentViewInteractive: Bool
        let dismissOnOverlayTap: Bool
        let onDismiss: (() -> Void)?

        init(when isInteractionBlocked: Binding<Bool>,
             onTopShow interactiveView: AnyView,
             closingDuration: Double = 0,
             isParentViewInteractive: Bool = false,
             dismissOnOverlayTap: Bool = true,
             onDismiss: (() -> Void)? = nil) {
            self._isInteractionBlocked = isInteractionBlocked
            self.interactiveView = interactiveView
            self.closingDuration = closingDuration
            self.isParentViewInteractive = isParentViewInteractive
            self.dismissOnOverlayTap = dismissOnOverlayTap
            self.onDismiss = onDismiss
        }
    }
}

// MARK: - Initializers

extension View {

    ///
    func disableInteractions(when isInteractionBlocked: Binding<Bool>,
                             onTopShow interactiveView: AnyView,
                             closingDuration: Double = 0,
                             isParentViewInteractive: Bool = false,
                             dismissOnOverlayTap: Bool = true,
                             onDismiss: (() -> Void)? = nil) -> some View {
        self.modifier(InteractionBlocker(isInteractionBlocked: isInteractionBlocked,
                                         interactiveView: interactiveView,
                                         closingDuration: closingDuration,
                                         isParentViewInteractive: isParentViewInteractive,
                                         isDismissedOnOverlayTap: dismissOnOverlayTap,
                                         onDismiss: onDismiss))
    }

    ///
    func disableInteractions(when isInteractionBlocked: Binding<Bool>,
                             onTopShow interactiveView: AnyView,
                             closingDuration: Double = 0,
                             isParentViewInteractive: Bool = false,
                             dismissOnOverlayTap: Bool = true,
                             onDismiss: @autoclosure @escaping () -> Void) -> some View {
        self.modifier(InteractionBlocker(isInteractionBlocked: isInteractionBlocked,
                                         interactiveView: interactiveView,
                                         closingDuration: closingDuration,
                                         isParentViewInteractive: isParentViewInteractive,
                                         isDismissedOnOverlayTap: dismissOnOverlayTap,
                                         onDismiss: onDismiss))
    }

    ///
    func disableInteractions(settings: InteractionBlocker.Settings) -> some View {
        self.modifier(InteractionBlocker(isInteractionBlocked: settings.$isInteractionBlocked,
                                         interactiveView: settings.interactiveView,
                                         closingDuration: settings.closingDuration,
                                         isParentViewInteractive: settings.isParentViewInteractive,
                                         isDismissedOnOverlayTap: settings.dismissOnOverlayTap,
                                         onDismiss: settings.onDismiss))
    }
}

