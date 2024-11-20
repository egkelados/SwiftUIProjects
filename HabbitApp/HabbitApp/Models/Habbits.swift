//
//  Habbits.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation

struct Habbits: Identifiable, Codable {
    var id = UUID()
    let title: String
    let category: Categories
    let description: String
}

enum Categories: String, CaseIterable, Codable {
    case health
    case finance
    case hustle
    case work
    case gym
}
