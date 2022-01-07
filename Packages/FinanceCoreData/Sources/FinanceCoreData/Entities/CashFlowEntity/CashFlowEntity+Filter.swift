//
//  CashFlowEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowEntity {

    enum Filter: EntityFilter {

        public var nsPredicate: NSPredicate? {
            nil
        }
    }
}