//
//  HabbitService.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation

class HabbitService {
    func fetchHabbits() -> [Habbits] {
        return [
            Habbits(title: "Morning Jog", category: .health, description: "something here"),
            Habbits(title: "Save $100", category: .finance, description: "something here"),
            Habbits(title: "Work on Side Project", category: .hustle, description: "something here"),
            Habbits(title: "Complete Team Report", category: .work, description: "something here"),
            Habbits(title: "Evening Workout", category: .gym, description: "something here"),
        ]
    }
}
