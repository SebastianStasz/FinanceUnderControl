//
//  AppController.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 12/01/2022.
//

import Foundation

final class AppController: ObservableObject {
    @Published private(set) var popupModel: PopupModel?

    func presentPopup(_ popupModel: PopupModel) {
        self.popupModel = popupModel
    }

    fileprivate func dismissPopup() {
        popupModel = nil
    }
}

extension PopupViewModifier {
    func dismissPopup() {
        appController.dismissPopup()
    }
}
