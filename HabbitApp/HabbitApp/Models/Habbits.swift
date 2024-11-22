//
//  Habbits.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation

struct Habbits: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let category: Categories
    let description: String
    var count: Int = 0
}

enum Categories: String, CaseIterable, Codable, Equatable {
    case health
    case finance
    case hustle
    case work
    case gym
}
