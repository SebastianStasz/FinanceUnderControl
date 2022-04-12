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
        case convertingJsonDataToString
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

    static func toJsonString<T: Encodable>(_ object: T) async throws -> String {
        try await Task {
            do {
                let data = try JSONEncoder().encode(object)
                guard let jsonString = String(data: data, encoding: .utf8) else {
                    throw Error.convertingJsonDataToString
                }
                return jsonString
            }
        }.value
    }
}
