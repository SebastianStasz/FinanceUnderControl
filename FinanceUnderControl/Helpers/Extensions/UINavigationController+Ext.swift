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

    func popToView<V: View>(ofType viewType: V.Type = V.self, animated: Bool = true) {
        guard let index = viewControllers.firstIndex(of: viewType.self) else {
            popToRootViewController(animated: animated)
            return
        }
        popToViewController(viewControllers[index], animated: animated)
    }

    func push<V: View, RV: View>(_ view: V, byReplacing viewToReplace: RV.Type = RV.self, animated: Bool) {
        guard let index = viewControllers.firstIndex(of: viewToReplace) else {
            push(view, animated: animated) ; return
        }
        var currentViewControllers = viewControllers
        currentViewControllers.remove(at: index)
        currentViewControllers.append(UIHostingController(rootView: view))
        setViewControllers(currentViewControllers, animated: animated)
    }
}

extension Array where Element == UIViewController {
    func firstIndex<V: View>(of view: V.Type = V.self) -> Int? {
        firstIndex(where: { $0 is UIHostingController<V> })
    }

    func contains<V: View>(_ view: V.Type = V.self) -> Bool {
        contains(where: { $0 is UIHostingController<V> })
    }

    func notContains<V: View>(_ view: V.Type = V.self) -> Bool {
        !contains(view)
    }
}
