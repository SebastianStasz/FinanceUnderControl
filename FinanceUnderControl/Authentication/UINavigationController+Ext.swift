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

    func presentResultView(viewData: ResultVD) {
        let resultView = ResultView(viewData: viewData)
        let viewController = UIHostingController(rootView: resultView)
        let nvc = UINavigationController(rootViewController: viewController)
        presentFullScreen(nvc)
    }
}

extension UIViewController {
    func addCloseButton() {
        let closeAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        navigationItem.rightBarButtonItem = .init(title: "Close", image: UIImage(systemName: SFSymbol.close.rawValue), primaryAction: closeAction)
    }
}
