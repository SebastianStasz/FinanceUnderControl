//
//  DesignSystemView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI
import SSUtils

struct DesignSystemView: View {
    
    var body: some View {
        BaseList("Design system", sectors: DesignSystem.sectors) {
            Navigation($0.rawValue, leadsTo: $0.body)
        }
    }
}


// MARK: - Preview

struct DesignSystemView_Previews: PreviewProvider {
    static var previews: some View {
        DesignSystemView()
            .embedInNavigationView()
    }
}
