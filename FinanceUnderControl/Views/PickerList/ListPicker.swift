//
//  ListPicker.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import SwiftUI

struct ListPicker<ListView: PickerList>: View{

    let title: String
    let listView: ListView

    var body: some View {
        NavigationLink(destination: listView) {
            ListPickerField(title: "\(title):", value: selectionName)
                .formField()
        }
    }

    private var selectionName: String {
        listView.selection.wrappedValue?.valueName ?? "---"
    }
}


// MARK: - Preview

struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        ListPicker(title: "From:", listView: CurrencyListView(selection: .constant(nil)))
            .embedInNavigationView()
    }
}
