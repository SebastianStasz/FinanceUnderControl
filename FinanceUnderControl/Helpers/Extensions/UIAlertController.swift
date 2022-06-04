//
//  UIAlertController.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit


extension UIAlertController {
    func addAction(title: String, style: UIAlertAction.Style = .default, action: @escaping () -> Void) {
        addAction(.init(title: title, style: style, handler: { _ in
            action()
        }))
    }

    func addCancelAction() {
        addAction(.init(title: .common_cancel, style: .cancel))
    }

    static func actionSheet(title: String? = nil) -> UIAlertController {
        .init(title: title, message: nil, preferredStyle: .actionSheet)
    }
}
