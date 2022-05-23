//
//  Pickerable.swift
//  Shared
//
//  Created by sebastianstaszczyk on 01/04/2022.
//

import Foundation

public protocol Pickerable: Hashable, Identifiable {
    var valueName: String { get }
}

public extension Pickerable {
    var id: String { valueName }
}

extension String: Pickerable {
    public var valueName: String { self }
}

extension Currency: Pickerable {
    public var valueName: String { code }
}
