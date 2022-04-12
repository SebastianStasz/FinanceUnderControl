//
//  Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 06/04/2022.
//

import Foundation

public protocol EntityDataModel: Codable, Equatable {
    associatedtype E: Entity

    func getModel(from controller: PersistenceController) async -> E.Model
}

public protocol Storable: Entity {
    associatedtype EntDataModel: EntityDataModel

    var dataModel: EntDataModel { get }
}
