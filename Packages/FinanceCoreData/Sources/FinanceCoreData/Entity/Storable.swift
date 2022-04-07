//
//  Storable.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 06/04/2022.
//

import Foundation

public protocol Storable: Entity {
    associatedtype EntityDataModel: Encodable

    var dataModel: EntityDataModel { get }
}
