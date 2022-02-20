//
//  TextStyle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

public enum TextStyle {
    case headlineBig
    case headlineSmall
    case bodyMedium
    case body
    case validation
    case currency

    public var font: Font.TextStyle {
        switch self {
        case .headlineBig:
            return .title3
        case .headlineSmall, .validation:
            return .caption
        case .bodyMedium, .body:
            return .callout
        case .currency:
            return .body
        }
    }

    public var weight: Font.Weight {
        switch self {
        case .headlineBig, .bodyMedium, .currency:
            return .medium
        default:
            return .regular
        }
    }

    public var textCase: Text.Case? {
        switch self {
        case .headlineSmall, .currency:
            return .uppercase
        default:
            return nil
        }
    }

    public var color: Color {
        switch self {
        case .headlineBig:
            return .white // TODO: Adapt to DS
        case .headlineSmall:
            return .gray // TODO: Adapt to DS
        case .validation:
            return .red.opacity(0.7) // TODO: Adapt to DS
        default:
            return .basicPrimaryInverted
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
