//
//  ImageAsset.swift
//  Shared
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import SwiftUI

protocol ImageAsset where Self: RawRepresentable, Self.RawValue == String {}

extension ImageAsset {
    var image: Image {
        Image(uiImage: UIImage(named: rawValue, in: .module, with: nil)!)
    }
}
