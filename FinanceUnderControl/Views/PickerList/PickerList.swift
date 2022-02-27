//
//  PickerList.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import SwiftUI

protocol PickerList: View {
    associatedtype Item: Pickerable

    init(selection: Binding<Item?>)
    var selection: Binding<Item?> { get set }
}
