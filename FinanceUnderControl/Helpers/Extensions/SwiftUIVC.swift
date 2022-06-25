//
//  SwiftUIVC.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import Combine
import SwiftUI

final class SwiftUIVC<Content: View>: UIHostingController<Content> {
    private let viewModel: ViewModel
    var cancellables: Set<AnyCancellable> = []

    init(viewModel: ViewModel, view: Content) {
        self.viewModel = viewModel
        super.init(rootView: view)
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
