//
//  SwiftUIVC.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import Combine
import SwiftUI

final class SwiftUIVC<Content: View>: UIHostingController<Content> {
    private let viewModel: ViewModel2
    var cancellables: Set<AnyCancellable> = []

    init(viewModel: ViewModel2, view: Content) {
        self.viewModel = viewModel
        super.init(rootView: view)
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
