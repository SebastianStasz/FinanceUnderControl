//
//  PreciousMetalFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Foundation
import SSUtils

final class PreciousMetalFormVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<PreciousMetalFormCoordinator.Destination>()
    }

    let binding = Binding()
    let formType: PreciousMetalFormType
    
    init(formType: PreciousMetalFormType, coordinator: CoordinatorProtocol? = nil) {
        self.formType = formType
        super.init(coordinator: coordinator)
    }
}
