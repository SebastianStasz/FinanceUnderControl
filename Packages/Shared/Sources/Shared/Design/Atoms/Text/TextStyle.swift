//
//  TextStyle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

public enum TextStyle {
    case headlineBig
    case headlineSmall(HeadlineSmallTextType = .normal)
    case bodyMedium
    case body(BodyTextType = .normal)
    case footnote(FootnoteTextType = .info)
    case currency

    public var font: Font.TextStyle {
        switch self {
        case .headlineBig:
            return .title3
        case .headlineSmall, .footnote:
            return .footnote
        case .bodyMedium, .body:
            return .subheadline
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

    public var textCase: SwiftUI.Text.Case? {
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
            return .primary // TODO: Adapt to DS
        case .headlineSmall(let type):
            return type.color
        case .footnote(let type):
            return type.color
        case .body(let type):
            return type.color
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
