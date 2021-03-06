//
//  UIViewController+Ext.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 27/04/2022.
//

import UIKit
import Shared
import SSUtils

extension UIViewController: BaseActions {

    func presentFullScreen(_ viewController: UIViewController, completion: Action? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: completion)
    }

    func setTabBarItem(title: String?, icon: SFSymbol, tag: Int) {
        tabBarItem = .init(title: title, image: .init(systemName: icon.rawValue), tag: tag)
    }
}
