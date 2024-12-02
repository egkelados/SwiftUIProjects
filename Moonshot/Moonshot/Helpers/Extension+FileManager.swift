//
//  Extension+FileManager.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 2/12/24.
//

import Foundation

extension FileManager {
    var documentDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func write(_ data: Data, to file: String) throws {
        let url = documentDirectory.appending(path: file)
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }

    func readString(from file: String) throws -> String {
        let url = documentDirectory.appending(path: file)
        return try String(contentsOf: url)
    }
}
