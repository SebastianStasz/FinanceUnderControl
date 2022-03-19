//
//  Section+SectorHeader.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import SwiftUI

extension Section where Parent == SectorHeader, Content: View, Footer == EmptyView {
    init?(_ header: SectorHeaderVD, shouldBePresented: Bool, content: @escaping () -> Content) {
        guard shouldBePresented else { return nil }
        self.init(header: SectorHeader(header), content: content)
    }
}
