//
//  PreciousMetalFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Foundation
import SSUtils
import SSValidation

final class PreciousMetalFormVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<PreciousMetalFormCoordinator.Destination>()
        let didTapConfirm = DriverSubject<Void>()
        let didTapClose = DriverSubject<Void>()
    }

    @Published private(set) var availableMetals: [PreciousMetalType] = []
    @Published private(set) var wasEdited = false
    @Published var formModel: PreciousMetalFormModel

    let binding = Binding()
    let amountInputVM = DecimalInputVM(validator: .alwaysValid)
    let formType: PreciousMetalFormType
    
    init(formType: PreciousMetalFormType, coordinator: CoordinatorProtocol? = nil) {
        self.formType = formType
        formModel = .init(for: formType)
        super.init(coordinator: coordinator)
    }
}
