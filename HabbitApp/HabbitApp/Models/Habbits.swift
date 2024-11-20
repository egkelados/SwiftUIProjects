//
//  Habbits.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation

struct Habbits: Identifiable {
    let id = UUID()
    let title: String
    let category: Categories

    enum Categories: String {
        case health
        case finance
        case hustle
        case work
        case gym
    }
}
