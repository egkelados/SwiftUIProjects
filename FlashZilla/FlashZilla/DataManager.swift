//
//  DataManager.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 20/1/25.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private let key = "Cards"

    func saveData(_ cards: [Card]) {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }

    func loadData() -> [Card] {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
        return []
    }
}
