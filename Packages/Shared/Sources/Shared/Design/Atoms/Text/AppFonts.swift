//
//  AppFonts.swift
//  Shared
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Foundation
import SwiftUI

public struct AppFonts {

    public static func register() {
        LatoFont.allCases.forEach {
            register(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }

    private static func register(bundle: Bundle, fontName: String, fontExtension: String) {
        let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension)!
        let fontDataProvider = CGDataProvider(url: fontURL as CFURL)!
        let font = CGFont(fontDataProvider)!
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
