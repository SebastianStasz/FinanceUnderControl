//
//  BaseView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 15/03/2022.
//

import SwiftUI

protocol BaseView: View {
    associatedtype BaseBody: View
    
    var baseBody: BaseBody { get }
    
    func onAppear()
}

extension BaseView {
    var body: some View {
        baseBody.onAppear(perform: onAppear)
    }
    
    func onAppear() {}
}
