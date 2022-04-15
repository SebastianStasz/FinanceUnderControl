//
//  CircleImage.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

extension CircleView {

    init(color: Color, icon: CashFlowCategoryIcon, size: CGFloat? = nil) {
        self.init(color: color, image: icon.rawValue, size: size)
    }
}
