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
    private let items: [FinanceStorage.ImportResult.Item]

    init(_ title: String, items: [FinanceStorage.ImportResult.Item]) {
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
                        Text(item.alreadyExists ? "Already exists" : "Will be created")
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
        FormView {
            Sector("test") {
                Navigation("Test", leadsTo: ImportFinanceResultList("Title", items: FinanceStorage.ImportResult.sampleItems))
            }
        }
        .asSheet(title: "Test")
//        Group {
//            ImportFinanceResultList("Title", items: FinanceStorage.ImportResult.sampleItems)
//            ImportFinanceResultList("Title", items: FinanceStorage.ImportResult.sampleItems).darkScheme()
//        }
//        .sizeThatFits(spacing: false)
    }
}
