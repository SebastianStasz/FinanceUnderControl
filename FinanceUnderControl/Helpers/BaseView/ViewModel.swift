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

    class BaseAction {
        let dismissView = PassthroughSubject<Void, Never>()

        init() {}
    }

    var cancellables: Set<AnyCancellable> = []
    let baseAction = BaseAction()
}
