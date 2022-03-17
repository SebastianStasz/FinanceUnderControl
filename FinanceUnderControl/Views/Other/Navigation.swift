//
//  Navigation.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import Shared

struct Navigation<Destination: View>: View {
    @State private var isPresented = false

    private let title: String
    private let destination: () -> Destination

    init(_ title: String,
         leadsTo destination: @autoclosure @escaping () -> Destination
    ) {
        self.title = title
        self.destination = destination
    }

    var body: some View {
        Button(action: goForward) { itemView }
            .buttonStyle(.plain)
            .navigation(isActive: $isPresented, destination: destination)
    }

    private var itemView: some View {
        HStack {
            Text(title).lineLimit(1)
            Spacer()
            SFSymbol.chevronForward.image
                .foregroundColor(.blue)
        }
        .card()
    }

    private func goForward() {
        isPresented = true
    }
}

// MARK: - Preview

struct NavigationItem_Previews: PreviewProvider {
    static var previews: some View {
        Navigation("Title", leadsTo: Text("Inside")).asPreview()
        Navigation("Title", leadsTo: Text("Inside")).asPreview()
            .preferredColorScheme(.dark)
    }
}
