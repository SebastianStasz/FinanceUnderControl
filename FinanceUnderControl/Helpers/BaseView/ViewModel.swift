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

    class BaseAction {
        let dismissView = DriverSubject<Void>()

        init() {}
    }

    var cancellables: Set<AnyCancellable> = []
    let baseAction = BaseAction()
}
