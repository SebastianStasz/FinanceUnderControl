//
//  PreciousMetalService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Combine
import Foundation

final class PreciousMetalService {
    private let firestore = FirestoreService.shared

    func create(_ preciousMetal: PreciousMetal) async throws {
        try await firestore.createOrEditDocument(withId: preciousMetal.id, in: .preciousMetals, data: preciousMetal.data)
    }

    func setOuncesAmount(_ amount: Decimal, for preciousMetal: PreciousMetal) async throws {
        let data = [PreciousMetal.Field.ouncesAmount.key: amount.asString]
        try await firestore.edit(withId: preciousMetal.id, in: .preciousMetals, data: data)
    }
}
