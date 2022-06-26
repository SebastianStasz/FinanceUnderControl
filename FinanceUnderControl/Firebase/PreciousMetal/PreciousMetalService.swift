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
        subscribePreciousMetals().output.assign(to: &$preciousMetals)
    }

    private func subscribePreciousMetals() -> FirestoreSubscription<[PreciousMetal]> {
        let configuration = QueryConfiguration<PreciousMetal>(sorters: [PreciousMetal.Order.type()])
        let subscription = firestore.subscribe(to: .preciousMetals, configuration: configuration)

        let preciousMetals = subscription.output
            .map { $0.map { PreciousMetal(from: $0) } }
            .eraseToAnyPublisher()

        return .init(output: preciousMetals, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
    }
}
