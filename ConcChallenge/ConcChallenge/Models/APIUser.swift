//
//  APIUser.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 27/12/24.
//

import Foundation

struct APIUser: Codable {
    let id: String
    let name: String
    let company: String
    let email: String
    let about: String
    let isActive: Bool
    let registered: String
    let friends: [APIFriend]
}

struct APIFriend: Codable {
    let id: String
    let name: String
}
