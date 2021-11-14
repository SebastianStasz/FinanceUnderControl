//
//  EntityFilter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public protocol EntityFilter {
    var nsPredicate: NSPredicate? { get }
}
