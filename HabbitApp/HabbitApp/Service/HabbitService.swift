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
            Habbits(title: "Morning Jog", category: .health),
            Habbits(title: "Save $100", category: .finance),
            Habbits(title: "Work on Side Project", category: .hustle),
            Habbits(title: "Complete Team Report", category: .work),
            Habbits(title: "Evening Workout", category: .gym),
        ]
    }
}
