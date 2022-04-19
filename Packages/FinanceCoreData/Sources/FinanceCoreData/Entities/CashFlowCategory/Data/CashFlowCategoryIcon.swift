//
//  CashFlowCategoryIcon.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import Foundation
import SSUtils

public enum CashFlowCategoryIcon: String {

    // MARK: s

    case carFill = "car.fill"
    case cartFill = "cart.fill"
    case creditcardFill = "creditcard.fill"
    case giftcardFill = "giftcard.fill"
    case bagFill = "bag.fill"
    case mouthFill = "mouth.fill"
    case cameraFill = "camera.fill"
    case phoneFill = "phone.fill"
    case envelopeFill = "envelope.fill"
    case facemaskFill = "facemask.fill"
    case mustacheFill = "mustache.fill"
    case houseFill = "house.fill"
    case tshirtFill = "tshirt.fill"
    case personFill = "person.fill"
    case ticketFill = "ticket.fill"
    case keyboardFill = "keyboard.fill"
    case magazineFill = "magazine.fill"
    case bookClosedFill = "book.closed.fill"
    case lanyardcardFill = "lanyardcard.fill"
    case graduationcapFill = "graduationcap.fill"

    // MARK: Other

    case guitarsFill = "guitars.fill"
    case keyFill = "key.fill"
    case starFill = "star.fill"
    case gear = "gear"
    case heartFill = "heart.fill"
    case dropFill = "drop.fill"
    case moonFill = "moon.fill"
    case musicNote = "music.note"
    case micFill = "mic.fill"
    case flameFill = "flame.fill"
    case cloudFill = "cloud.fill"
    case sunMaxFill = "sun.max.fill"
    case umbrellaFill = "umbrella.fill"
    case paperplaneFill = "paperplane.fill"
    case externaldriveFill = "externaldrive.fill"
    case powerplugFill = "powerplug.fill"
    case desktopcomputer = "desktopcomputer"
    case candybarphone = "candybarphone"
    case headphones = "headphones"
    case hifispeakerFill = "hifispeaker.fill"
    case busFill = "bus.fill"
    case trainSideFrontCar = "train.side.front.car"
    case bicycle = "bicycle"
    case scooter = "scooter"
    case parkingsign = "parkingsign"
    case bedDoubleFill = "bed.double.fill"
    case hareFill = "hare.fill"
    case combFill = "comb.fill"
    case alarmFill = "alarm.fill"
    case takeoutbagAndCupAndStrawFill = "takeoutbag.and.cup.and.straw.fill"
    case cupAndSaucerFill = "cup.and.saucer.fill"
    case figureWalk = "figure.walk"
    case figureRoll = "figure.roll"
    case chartBarXaxis = "chart.bar.xaxis"
    case sdcardFill = "sdcard.fill"
    case giftFill = "gift.fill"
    case lightbulbFill = "lightbulb.fill"
    case bandageFill = "bandage.fill"
    case suitcaseFill = "suitcase.fill"
    case crossCaseFill = "cross.case.fill"
    case rulerFill = "ruler.fill"
    case buildingColumnsFill = "building.columns.fill"
    case pinFill = "pin.fill"
    case hammerFill = "hammer.fill"
    case stethoscope = "stethoscope"
    case printerFill = "printer.fill"
    case screwdriverFill = "screwdriver.fill"
    case paintbrushPointedFill = "paintbrush.pointed.fill"
    case paintbrushFill = "paintbrush.fill"
    case banknoteFill = "banknote.fill"
    case leafFill = "leaf.fill"
    case airplane = "airplane"
    case fuelpumpFill = "fuelpump.fill"
    case gameControllerFill = "gamecontroller.fill"
    case pawprintFill = "pawprint.fill"
    case pillsFill = "pills.fill"

    // MARK: Generic

    case circleFrid2x2Fill = "circle.grid.2x2.fill"
    case archiveboxFill = "archivebox.fill"
    case bookmarkFill = "bookmark.fill"
    case folderFill = "folder.fill"
    case trayFill = "tray.fill"
    case sealFill = "seal.fill"
    case docFill = "doc.fill"
    case mapFill = "map.fill"
}

extension CashFlowCategoryIcon: CaseIterable {}
extension CashFlowCategoryIcon: Codable {}

extension CashFlowCategoryIcon: Identifiable {
    public var id: String { rawValue }

    public static var `default`: CashFlowCategoryIcon {
        .folderFill
    }
}

