//
//  FileHelper.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/04/2022.
//

import Foundation
import SSUtils

struct FileHelper {

    enum Error: Swift.Error {
        case accessDenied
    }

    static func getTemporaryURL(forContent content: String, fileName: String, fileExtension: FileExtension) throws -> URL {
        let tempDirectory = FileManager.temporaryURL(fileName: fileName, fileExtension: fileExtension)
        do { try content.write(to: tempDirectory, atomically: true, encoding: .utf8) }
        return tempDirectory
    }

    static func getModelFrom<T: Decodable>(_ url: URL) async throws -> T {
        try await Task {
            guard url.startAccessingSecurityScopedResource() else {
                throw Error.accessDenied
            }
            let data = try Data(contentsOf: url)
            url.stopAccessingSecurityScopedResource()
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
        .value
    }
}
