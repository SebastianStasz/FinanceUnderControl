//
//  TextStyle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

public enum TextStyle {
    case title
    case subtitle
    case navHeadline
    
    case headlineLarge
    case headlineSmall(HeadlineSmallTextType = .normal)
    case bodyMedium
    case body(BodyTextType = .normal)
    case footnote(FootnoteTextType = .info)
    case currency

    public var color: Color {
        switch self {
        case .subtitle:
            return .grayMain
        case .headlineLarge:
            return .white // TODO: Adapt to DS
        case let .headlineSmall(type):
            return type.color
        case let .footnote(type):
            return type.color
        case let .body(type):
            return type.color
        default:
            return .basicPrimaryInverted
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

    public var font: Font {
        switch self {
        case .title:
            return .custom(LatoFont.latoBold.rawValue, size: 42, relativeTo: .largeTitle)

        case .subtitle:
            return .custom(LatoFont.latoRegular.rawValue, size: 19, relativeTo: .title3)

        case .navHeadline:
            return .custom(LatoFont.latoBlack.rawValue, size: 24, relativeTo: .title3)

        case .headlineLarge:
            return .system(.title3).weight(.medium)

        case .headlineSmall:
            return .system(.footnote)

        case .bodyMedium:
            return .system(.subheadline).weight(.medium)

        case .body:
            return .system(.subheadline)

        case .footnote:
            return .system(.footnote)

        case .currency:
            return .system(.body, design: .monospaced).weight(.medium)
        }
    }
}

public extension View {
    func textStyle(_ style: TextStyle) -> some View {
        self.font(style.font)
            .textCase(style.textCase)
            .foregroundColor(style.color)
    }
}
