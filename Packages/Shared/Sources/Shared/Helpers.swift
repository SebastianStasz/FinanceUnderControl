//
//  Helpers.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public typealias Action = () -> Void

extension View {
    func sizeThatFits() -> some View {
        self.padding().previewLayout(.sizeThatFits)
    }
}
