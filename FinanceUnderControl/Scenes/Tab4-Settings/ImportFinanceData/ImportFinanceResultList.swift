//
//  ImportFinanceResultList.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/04/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

struct ImportFinanceResultList: View {

    private let title: String
    private let items: [FinanceDataImporter.ResultItem]

    init(_ title: String, items: [FinanceDataImporter.ResultItem]) {
        self.title = title
        self.items = items
    }

    var body: some View {
        FormView {
            Sector(title) {
                ForEach(items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.willBeCreated ? "Will be created" : "Already exists")
                    }
                    .card()
                }
            }
        }
    }
}

// MARK: - Preview

struct ImportFinanceResultList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImportFinanceResultList("Title", items: FinanceDataImporter.Result.sampleItems)
            ImportFinanceResultList("Title", items: FinanceDataImporter.Result.sampleItems).darkScheme()
        }
        .sizeThatFits(spacing: false)
    }
}
