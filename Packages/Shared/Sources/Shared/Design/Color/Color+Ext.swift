//
//  Color+Ext.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public extension Color {
    private typealias Basic = ColorDesign.Basic

    // MARK: - Basic

    static var basicPrimary: Color {
        Basic.basic_primary.color
    }

    static var basicSecondary: Color {
        Basic.basic_secondary.color
    }
}
