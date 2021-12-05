//
//  ListPicker.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import SwiftUI

struct ListPicker<ListView: PickerList>: View{

    @State private var isListPresented = false

    let title: String
    let listView: ListView

    var body: some View {
        ListPickerField(title: title, value: selectionName)
            .onTapGesture { isListPresented = true }
            .navigation(isActive: $isListPresented) { listView }
    }

    private var selectionName: String {
        listView.selection.wrappedValue?.name ?? "--"
    }
}


// MARK: - Preview

struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        ListPicker(title: "From:", listView: CurrencyListView(selection: .constant(nil)))
    }
}
