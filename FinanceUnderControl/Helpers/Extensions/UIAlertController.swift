//
//  UIAlertController.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit


extension UIAlertController {
    func addAction(title: String, action: @escaping () -> Void) {
        addAction(.init(title: title, style: .default, handler: { _ in
            action()
        }))
    }

    func addCancelAction() {
        addAction(.init(title: "Cancel", style: .cancel))
    }

    static func actionSheet(title: String) -> UIAlertController {
        .init(title: title, message: nil, preferredStyle: .actionSheet)
    }
}
