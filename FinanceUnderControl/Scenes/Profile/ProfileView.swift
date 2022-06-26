//
//  ProfileView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 26/06/2022.
//

import Shared
import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileVM

    var body: some View {
        Button("Logout") { viewModel.binding.didTapLogout.send() }
            .navigationBar(title: "Profile") {
                Button(systemImage: SFSymbol.close.rawValue) {
                    viewModel.binding.navigateTo.send(.dismiss)
                }
            }
    }
}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .init())
        ProfileView(viewModel: .init()).darkScheme()
    }
}
