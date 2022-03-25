//
//  SwiftUIView.swift
//  
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public struct Navigation<Destination: View>: View {
    @State private var isPresented = false

    private let title: String
    private let destination: () -> Destination

    public init(_ title: String, leadsTo destination: @autoclosure @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }

    public var body: some View {
        Text(title).lineLimit(1)
            .trailingAction(.forward(action: goForward))
            .card()
            .navigation(isActive: $isPresented, destination: destination)
    }

    private func goForward() {
        isPresented = true
    }
}

// MARK: - Preview

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation("Title", leadsTo: Text("Inside")).sizeThatFits()
        Navigation("Title", leadsTo: Text("Inside")).sizeThatFits()
            .preferredColorScheme(.dark)
    }
}
