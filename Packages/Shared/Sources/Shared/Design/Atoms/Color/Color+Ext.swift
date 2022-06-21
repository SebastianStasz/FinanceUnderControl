//
//  Color+Ext.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

public extension Color {
    private typealias Accent = ColorDesign.Accent
    private typealias Color = ColorDesign.Color
    private typealias Background = ColorDesign.Background
    private typealias Gray = ColorDesign.Gray
    private typealias Basic = ColorDesign.Basic

    // MARK: - Accent

    static let accentPrimary = Accent.accent_primary.color

    // MARK: - Color

    static let mainGreen = Color.main_green.color
    static let mainRed = Color.main_red.color

    // MARK: - Background

    static let backgroundPrimary = Background.background_primary.color
    static let backgroundSecondary = Background.background_secondary.color

    // MARK: Accent Gray

    static let grayMain = Gray.gray_main.color

    // MARK: - Basic

    static let basicPrimary = Basic.basic_primary.color
    static let basicPrimaryInverted = Basic.basic_primary_inverted.color
}
