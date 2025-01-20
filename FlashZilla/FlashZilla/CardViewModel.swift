//
//  CardViewModel.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 20/1/25.
//

import Foundation
import Observation

@Observable
class CardViewModel {
    var cards: [Card] = []
    var isActive = true
    var timeRemaining = 100

    init() {
        loadData()
    }

    func loadData() {
        cards = DataManager.shared.loadData()
    }

    func removeCard(at index: Int) {
        guard index >= 0 else { return }

        cards.remove(at: index)

        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        cards = DataManager.shared.loadData()
    }

    func saveData() {
        DataManager.shared.saveData(cards)
    }
}
