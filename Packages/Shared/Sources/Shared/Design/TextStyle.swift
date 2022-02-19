//
//  TextStyle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

public enum TextStyle {
    case headlineBig
    case bodyMedium
    case body
    case caption
    case currency

    public var font: Font.TextStyle {
        switch self {
        case .headlineBig:
            return .title3
        case .bodyMedium, .body:
            return .callout
        case .caption:
            return .caption
        case .currency:
            return .body
        }
    }

    public var weight: Font.Weight {
        switch self {
        case .headlineBig, .bodyMedium, .currency:
            return .medium
        case .body, .caption:
            return .regular
        }
    }

    public var textCase: Text.Case? {
        switch self {
        case .caption, .currency:
            return .uppercase
        default:
            return nil
        }
    }

    public var color: Color {
        switch self {
        case .headlineBig:
            return .white // TODO: Change
        case .bodyMedium, .body, .currency:
            return .basicPrimaryInverted
        case .caption:
            return .gray // TODO: Change
        }
    }

    public var design: Font.Design {
        switch self {
        case .currency:
            return .monospaced
        default:
            return .default
        }
    }
}

public extension View {
    func textStyle(_ style: TextStyle) -> some View {
        self.foregroundColor(style.color)
            .font(.system(style.font, design: style.design).weight(style.weight))
            .textCase(style.textCase)
    }
}
