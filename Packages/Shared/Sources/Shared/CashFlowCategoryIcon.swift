//
//  CashFlowCategoryIcon.swift
//  Shared
//
//  Created by sebastianstaszczyk on 13/05/2022.
//

public enum CashFlowCategoryIcon: String {

    // MARK: Transport 12

    case figureWalk = "figure.walk"
    case figureRoll = "figure.roll"
    case bicycle = "bicycle"
    case scooter = "scooter"
    case carFill = "car.fill"
    case busFill = "bus.fill"
    case tramFill = "tram.fill"
    case airplane = "airplane"
    case ferryFill = "ferry.fill"
    case fuelpumpFill = "fuelpump.fill"
    case ticketFill = "ticket.fill"
    case mapFill = "map.fill"

    // MARK: Human 6

    case mustacheFill = "mustache.fill"
    case mouthFill = "mouth.fill"
    case noseFill = "nose.fill"
    case handRaisedFill = "hand.raised.fill"
    case brain = "brain"
    case tshirtFill = "tshirt.fill"

    // MARK: Nature 12

    case globeEuropeAfricaFill = "globe.europe.africa.fill"
    case flameFill = "flame.fill"
    case boltFill = "bolt.fill"
    case dropFill = "drop.fill"
    case leafFill = "leaf.fill"
    case snowflake = "snowflake"
    case cloudFill = "cloud.fill"
    case moonFill = "moon.fill"
    case sunMaxFill = "sun.max.fill"
    case pawprintFill = "pawprint.fill"
    case hareFill = "hare.fill"
    case ladybugFill = "ladybug.fill"

    // MARK: Commerce 6

    case bagFill = "bag.fill"
    case cartFill = "cart.fill"
    case creditcardFill = "creditcard.fill"
    case banknoteFill = "banknote.fill"
    case briefcaseFill = "briefcase.fill"
    case docFill = "doc.fill"

    // MARK: Health 12

    case alarmFill = "alarm.fill"
    case scissors = "scissors"
    case bandageFill = "bandage.fill"
    case paintbrushFill = "paintbrush.fill"
    case paintbrushPointedFill = "paintbrush.pointed.fill"
    case heartFill = "heart.fill"
    case facemaskFill = "facemask.fill"
    case pillsFill = "pills.fill"
    case bedDoubleFill = "bed.double.fill"
    case houseFill = "house.fill"
    case buildingFill = "building.fill"
    case keyFill = "key.fill"

    // MARK: Generic 6

    case circleGrid2x2Fill = "circle.grid.2x2.fill"
    case archiveboxFill = "archivebox.fill"
    case bookmarkFill = "bookmark.fill"
    case trayFill = "tray.fill"
    case sealFill = "seal.fill"
    case folderFill = "folder.fill"

    // MARK: Objects and tools 12

    case bookClosedFill = "book.closed.fill"
    case graduationcapFill = "graduationcap.fill"
    case umbrellaFill = "umbrella.fill"
    case hammerFill = "hammer.fill"
    case screwdriverFill = "screwdriver.fill"
    case stethoscope = "stethoscope"
    case powerplugFill = "powerplug.fill"
    case combFill = "comb.fill"
    case cupAndSaucerFill = "cup.and.saucer.fill"
    case takeoutbagAndCupAndStrawFill = "takeoutbag.and.cup.and.straw.fill"
    case forkKnife = "fork.knife"
    case giftFill = "gift.fill"

    // MARK: Devices 12

    case hifispeakerFill = "hifispeaker.fill"
    case headphones = "headphones"
    case gameControllerFill = "gamecontroller.fill"
    case printerFill = "printer.fill"
    case desktopcomputer = "desktopcomputer"
    case candybarphone = "candybarphone"
    case micFill = "mic.fill"
    case phoneFill = "phone.fill"
    case guitarsFill = "guitars.fill"
    case envelopeFill = "envelope.fill"
    case lightbulbFill = "lightbulb.fill"
    case cameraFill = "camera.fill"

    public static var groups: [IconGroup] {
        var all = CashFlowCategoryIcon.allCases

        let transport = IconGroup(title: "Transport", icons: Array(all.prefix(12)))
        all.removeFirst(12)

        let human = IconGroup(title: "Human", icons: Array(all.prefix(6)))
        all.removeFirst(6)

        let nature = IconGroup(title: "Nature", icons: Array(all.prefix(12)))
        all.removeFirst(12)

        let commerce = IconGroup(title: "Commerce", icons: Array(all.prefix(6)))
        all.removeFirst(6)

        let health = IconGroup(title: "Health", icons: Array(all.prefix(12)))
        all.removeFirst(12)

        let generic = IconGroup(title: "Generic", icons: Array(all.prefix(6)))
        all.removeFirst(6)

        let objectAndTools = IconGroup(title: "ObjectAndTools", icons: Array(all.prefix(12)))
        all.removeFirst(12)

        let devices = IconGroup(title: "Devices", icons: Array(all.prefix(12)))
        all.removeFirst(12)

        return [transport, human, nature, commerce, health, generic, objectAndTools, devices]
    }
}

extension CashFlowCategoryIcon: CaseIterable {}
extension CashFlowCategoryIcon: Codable {}

extension CashFlowCategoryIcon: Identifiable {
    public var id: String { rawValue }

    public static var `default`: CashFlowCategoryIcon {
        .folderFill
    }
}

public struct IconGroup: Identifiable {
    public let title: String
    public let icons: [CashFlowCategoryIcon]

    public var isLast: Bool {
        title == "Devices"
    }

    public var id: String {
        title
    }
}
