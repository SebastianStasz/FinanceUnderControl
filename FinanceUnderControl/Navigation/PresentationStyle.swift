//
//  PresentationStyle.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/04/2022.
//

import UIKit

enum PresentationStyle {
    case push(on: UINavigationController)
    case presentModally(on: UIViewController)
    case presentFullScreen(on: UIViewController)
}
