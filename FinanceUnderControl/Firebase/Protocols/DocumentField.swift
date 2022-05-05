//
//  DocumentField.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/05/2022.
//

import Foundation

protocol DocumentField: RawRepresentable where RawValue == String, Self: CaseIterable {
    var key: String { get }
}

extension DocumentField {
    var key: String { rawValue }
}
