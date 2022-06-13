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

    let wallet: Wallet
    let binding = Binding()
    let balanceInputVM = DecimalInputVM()

    init(wallet: Wallet) {
        self.wallet = wallet
        super.init()
    }

    override func viewDidLoad() {
        balanceInputVM.setValue(to: wallet.balance)
        balanceInputVM.isValid.assign(to: &$isFormValid)
    }
}
