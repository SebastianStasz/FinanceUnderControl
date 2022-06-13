//
//  WalletFormVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation
import SSUtils
import SSValidation

final class WalletFormVM: ViewModel {

    struct Binding {
        let didTapConfirm = DriverSubject<Void>()
    }

    @Published private(set) var isFormValid = false

    let binding = Binding()
    let balanceInputVM = DecimalInputVM()

    init(wallet: Wallet) {
        super.init()
        balanceInputVM.setValue(to: wallet.balance)
    }

    override func viewDidLoad() {
        balanceInputVM.isValid.assign(to: &$isFormValid)
    }
}
