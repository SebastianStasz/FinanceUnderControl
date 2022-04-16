//
//  Color+Ext.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public extension Color {
    private typealias Background = ColorDesign.Background
    private typealias AccentGray = ColorDesign.AccentGray
    private typealias Basic = ColorDesign.Basic

    // MARK: - Background

    static let backgroundPrimary = Background.background_primary.color
    static let backgroundSecondary = Background.background_secondary.color

    // MARK: Accent Gray

    static let grayMedium = AccentGray.gray_medium.color

    // MARK: - Basic

    static let basicPrimary = Basic.basic_primary.color
    static let basicPrimaryInverted = Basic.basic_primary_inverted.color
    static let basicSecondary = Basic.basic_secondary.color

    static let accentRed = Color.red
    static let accentGreen = Color.green
}
