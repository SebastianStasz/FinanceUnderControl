//
//  UINavigationController+Ext.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/04/2022.
//

import Shared
import SwiftUI

extension UINavigationController {

    func push<Content: View>(_ content: Content, animated: Bool = true) {
        pushViewController(UIHostingController(rootView: content), animated: animated)
    }

    func presentResultView(viewData: ResultData, completion: (() -> Void)? = nil) {
        let action = viewData.action ?? onSelf { $0.dismiss(animated: true) }
        let viewData = ResultVD(type: viewData.type, title: viewData.title, message: viewData.message, action: action)
        let viewController = UIHostingController(rootView: ResultView(viewData: viewData))
        presentFullScreen(viewController, completion: nil)
    }

    func popToView<V: View>(ofType: V.Type = V.self, animated: Bool = true) {
        guard let index = viewControllers.firstIndex(where: { $0 is UIHostingController<V> }) else {
            popToRootViewController(animated: animated)
            return
        }
        popToViewController(viewControllers[index], animated: animated)
    }
}
