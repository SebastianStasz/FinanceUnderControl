//
//  ViewModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Combine
import Foundation
import SSUtils

class ViewModel: ObservableObject, CombineHelper {

    @Published var isLoading = false

    var cancellables: Set<AnyCancellable> = []
    private let coordinator: CoordinatorProtocol?

    init(coordinator: CoordinatorProtocol? = nil) {
        self.coordinator = coordinator
        commonInit()
    }

    func commonInit() {}

    func viewDidLoad() {}
    func viewDidDisappear() {}
}
