//
//  Color+Ext.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public extension Color {
    private typealias Accent = ColorDesign.Accent
    private typealias Background = ColorDesign.Background
    private typealias Gray = ColorDesign.Gray
    private typealias Basic = ColorDesign.Basic

    // MARK: - Background

    static let accentPrimary = Accent.accent_primary.color

    // MARK: - Background

    static let backgroundPrimary = Background.background_primary.color
    static let backgroundSecondary = Background.background_secondary.color

    // MARK: Accent Gray

    static let grayMain = Gray.gray_main.color

    // MARK: - Basic

    static let basicPrimary = Basic.basic_primary.color
    static let basicPrimaryInverted = Basic.basic_primary_inverted.color
    static let basicSecondary = Basic.basic_secondary.color

    static let accentRed = Color.red
    static let accentGreen = Color.green
}
