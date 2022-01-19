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
        List {
            Section("Form") {
                ForEach(DesignSystem.allCases) {
                    NavigationLink($0.title, destination: $0.body)
                }
            }
        }
        .navigationTitle("Design system")
    }
}


// MARK: - Preview

struct DesignSystemView_Previews: PreviewProvider {
    static var previews: some View {
        DesignSystemView()
            .embedInNavigationView()
    }
}
