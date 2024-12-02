//
//  Result.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    
    var description: String {
        terms?["description"]?.first ?? "No further infos..."
    }
    
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
}
