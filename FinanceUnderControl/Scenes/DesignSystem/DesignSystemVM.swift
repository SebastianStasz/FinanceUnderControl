//
//  DesignSystemVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/06/2022.
//

import Combine
import Foundation

final class DesignSystemVM: ViewModel {

    struct Binding {
        let navigateTo = PassthroughSubject<DesignSystemCoordinator.Destination, Never>()
    }

    let binding = Binding()
}
