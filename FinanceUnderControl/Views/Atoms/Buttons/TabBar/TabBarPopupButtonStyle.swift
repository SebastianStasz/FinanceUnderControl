//
//  TabBarPopupButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

struct TabBarPopupButtonStyle: ButtonStyle {

    let image: String

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.red)

            Image(systemName: image)
                .foregroundColor(.white)
                .font(.system(size: 19, weight: .medium))
        }
        .shadow(color: .black.opacity(0.02), radius: 5)
    }
}
