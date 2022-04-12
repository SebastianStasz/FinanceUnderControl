//
//  FinanceDataFile.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import FinanceCoreData
import UniformTypeIdentifiers
import SwiftUI

struct FinanceDataFile: FileDocument {
    static var readableContentTypes: [UTType] = [.json]

    private let financeData: FinanceData?
    private let fileName: String

    init(data: FinanceData, fileName: String) {
        self.financeData = data
        self.fileName = fileName
    }

    init(configuration: ReadConfiguration) throws {
        self.financeData = nil
        self.fileName = ""
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(financeData)
        let file = FileWrapper(regularFileWithContents: data)
        file.filename = fileName
        return file
    }
}
