//
//  ProfileVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 26/06/2022.
//

import FirebaseAuth
import Foundation
import SSUtils

final class ProfileVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<ProfileCoordinator.Destination>()
        let didTapLogout = DriverSubject<Void>()
    }

    let binding = Binding()

    override func viewDidLoad() {
        binding.didTapLogout
            .perform { try! Auth.auth().signOut() }
            .sinkAndStore(on: self, action: { _, _ in })
    }
}
