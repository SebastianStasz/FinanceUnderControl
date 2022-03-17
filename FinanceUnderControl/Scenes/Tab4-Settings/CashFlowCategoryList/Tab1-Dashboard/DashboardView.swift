//
//  DashboardView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        Text("Dashboard")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .inTabBarPreview()
    }
}
