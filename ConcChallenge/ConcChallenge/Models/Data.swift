//
//  Data.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import Foundation

struct User: Codable, Hashable {
    let id: String
    let name: String
    let company: String
    let email: String
    let about: String
    let isActive: Bool
    // add registered which is date
    let friends: [Friend]

    static var example: User {
        User(id: UUID().uuidString, name: "someone", company: "OneBigOne", email: "som@gmail.com", about: "Here is the mock data for the preview", isActive: true, friends: [Friend(id: UUID().uuidString, name: "one friend"), Friend(id: UUID().uuidString, name: "second one friend")])
    }
}

struct Friend: Codable, Hashable {
    let id: String
    let name: String
}
