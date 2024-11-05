//
//  String+Extension.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 5/11/24.
//

import Foundation

///check if the selected string has whitespaces, if so and is empty return false....
extension String {
    func isEmptyOrWhitespace() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    var trimmedString: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
