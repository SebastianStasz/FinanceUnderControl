//
//  CashFlowCategoryIcon.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import Foundation
import SSUtils

public enum CashFlowCategoryIcon: String {
    case houseFill = "house.fill"
    case gameControllerFill = "gamecontroller.fill"
    case carFill = "car.fill"
    case airplane = "airplane"
    case fuelpumpFill = "fuelpump.fill"
    case personFill = "person.fill"
    case tshirtFill = "tshirt.fill"
    case pawprintFill = "pawprint.fill"
    case leafFill = "leaf.fill"
    case paintbrushFill = "paintbrush.fill"
    case banknoteFill = "banknote.fill"
    case bagFill = "bag.fill"
    case cartFill = "cart.fill"
    case creditcardFill = "creditcard.fill"
    case heartFill = "heart.fill"
    case pillsFill = "pills.fill"
    case trashFill = "trash.fill"
    case sunMaxFill = "sun.max.fill"
    case moonFill = "moon.fill"
    case cloudFill = "cloud.fill"
    case umbrellaFill = "umbrella.fill"
    case flameFill = "flame.fill"
    case paperplaneFill = "paperplane.fill"
    case graduationcapFill = "graduationcap.fill"
    case bookClosedFill = "book.closed.fill"
    case bookmarkFill = "bookmark.fill"
    case checkmarkSealFill = "checkmark.seal.fill"
    case xmarkSealFill = "xmark.seal.fill"
    case externaldriveFill = "externaldrive.fill"
    case archiveboxFill = "archivebox.fill"
    case folderFill = "folder.fill"
    case trayFill = "tray.fill"
    case docFill = "doc.fill"
    case circleFrid2x2Fill = "circle.grid.2x2.fill"
    case circleFridCrossFill = "circle.grid.cross.fill"
    case docTextFill = "doc.text.fill"
    case docPlaintextFill = "doc.plaintext.fill"
    case dropFill = "drop.fill"
    case megaphoneFill = "megaphone.fill"
    case speakerWave3Fill = "speaker.wave.3.fill"
    case musicNote = "music.note"
    case circleFill = "circle.fill"
}

extension CashFlowCategoryIcon: CaseIterable {}
extension CashFlowCategoryIcon: Codable {}

extension CashFlowCategoryIcon: Identifiable {
    public var id: String { rawValue }
}

extension CashFlowCategoryIcon: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryIcon {
        return .bagFill
    }
}
