//
//  View+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import SwiftUI

extension View {
    func infoAlert(_ title: String = "Info", isPresented: Binding<Bool>, message: String) -> some View {
        alert(title, isPresented: isPresented, actions: {}, message: { Text(message) })
    }
}
