//
//  Data.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import Foundation
import SwiftData

@Model
class User: Codable, Hashable {
    var id: String
    var name: String
    var company: String
    var email: String
    var about: String
    var isActive: Bool
    var registered: Date
    @Relationship var friends: [Friend] = []

    init(id: String, name: String, company: String, email: String, about: String, isActive: Bool, registered: Date, friends: [Friend] = []) {
        self.id = id
        self.name = name
        self.company = company
        self.email = email
        self.about = about
        self.isActive = isActive
        self.registered = registered
        self.friends = friends
    }

    enum CodingKeys: CodingKey {
        case id, name, company, email, about, isActive, registered, friends
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        about = try container.decode(String.self, forKey: .about)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        let registeredString = try container.decode(String.self, forKey: .registered)
        registered = ISO8601DateFormatter().date(from: registeredString) ?? Date()
        friends = try container.decode([Friend].self, forKey: .friends)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(about, forKey: .about)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(ISO8601DateFormatter().string(from: registered), forKey: .registered)
        try container.encode(friends, forKey: .friends)
    }

    
    static var example: User {
        let friend1 = Friend(id: "f1", name: "Alice")
        let friend2 = Friend(id: "f2", name: "Bob")
        return User(
            id: "1",
            name: "John Doe",
            company: "TechCorp",
            email: "john.doe@example.com",
            about: "John is a software engineer.",
            isActive: true,
            registered: ISO8601DateFormatter().date(from: "2023-11-15T05:42:00Z") ?? Date(),
            friends: [friend1, friend2]
        )
    }
}

@Model
class Friend: Codable, Hashable {
    var id: String
    var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case id, name
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }

    static var example: Friend {
        Friend(id: "f1", name: "Alice")
    }
}
