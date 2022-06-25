//
//  PreciousMetalService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Combine
import Foundation

final class PreciousMetalService {
    static let shared = PreciousMetalService()
    private let firestore = FirestoreService.shared

    @Published private(set) var preciousMetals: [PreciousMetal] = []

    private init() {
//        subscribePreciousMetals().output.assign(to: &$preciousMetals)
    }

//    private func subscribePreciousMetals() -> FirestoreSubscription<[Wallet]> {
//    }
}
