//
//  HabbitViewModel.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation
import Observation

@Observable
class HabbitViewModel {
    var habbits = [Habbits]()
    private let habbitService = HabbitService()

    init() {
        loadFromUserDefaults()
    }

    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(habbits) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }

    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "SavedData"),
           let decoded = try? JSONDecoder().decode([Habbits].self, from: data)
        {
            habbits = decoded
        }
    }

    func loadHabbits() {
        habbits = habbitService.fetchHabbits()
        saveToUserDefaults()
    }

    func deleteHabbit(at index: IndexSet) {
        habbits.remove(atOffsets: index)
        saveToUserDefaults()
    }

    func save(habbit: Habbits) {
        habbits.append(habbit)
        saveToUserDefaults()
    }
}
