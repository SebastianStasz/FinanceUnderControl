//
//  SFSymbolDSView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import SwiftUI

struct SFSymbolDSView: View {
    var body: some View {
        Group {
            ForEach(SFSymbol.allCases) {
                $0.image
                    .designSystemComponent($0.name)
            }
        }
        .designSystemView("SF symbol")
    }
}

struct SFSymbolDSView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolDSView()
        SFSymbolDSView().darkScheme()
    }
}
