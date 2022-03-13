//
//  ListSector.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/03/2022.
//

import Foundation

struct ListSector<T: Identifiable> {
    let title: String
    let elements: [T]
    let visibleIfEmpty: Bool
    
    init(_ title: String, elements: [T], visibleIfEmpty: Bool = false) {
        self.title = title
        self.elements = elements
        self.visibleIfEmpty = visibleIfEmpty
    }
}

extension ListSector {
    var isNotEmpty: Bool {
        elements.isNotEmpty
    }
    
    static func unvisibleSector(_ elements: [T]) -> [ListSector] {
        [.init(unvisibleSectorTitle, elements: elements)]
    }
    
    static var unvisibleSectorTitle: String {
        "Unvisible Sector Title"
    }
}

extension ListSector: Identifiable {
    var id: String { title }
}
