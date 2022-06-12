//
//  ResultView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/04/2022.
//

import SwiftUI

public struct ResultView: View {

    private let viewData: ResultVD

    public init(viewData: ResultVD) {
        self.viewData = viewData
    }

    public var body: some View {
        VStack(alignment: .center, spacing: .micro) {
            Text(viewData.title, style: .title)
            Text(viewData.message, style: .subtitle)
            BaseButton(.common_ok, role: .primary, action: viewData.action)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let success = ResultVD(type: .success, title: "Title", message: "messge", action: {})
        let error = ResultVD(type: .error, title: "Title", message: "messge", action: {})
        ResultView(viewData: success)
        ResultView(viewData: error)
        ResultView(viewData: success).darkScheme()
        ResultView(viewData: error).darkScheme()
    }
}
