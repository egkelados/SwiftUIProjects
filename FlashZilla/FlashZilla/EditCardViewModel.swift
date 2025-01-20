//
//  EditCardViewModel.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 20/1/25.
//

import Foundation

@Observable
class EditCardViewModel {
    var cards = [Card]()
    var newPrompt = ""
    var newAnswer = ""
    let dataManager = DataManager.shared

    init() {
        loadData()
    }

    func done() {
        newPrompt = ""
        newAnswer = ""
    }
    func loadData() {
        cards = dataManager.loadData()
    }

    func addCard(_ newPrompt: String, _ newAnswer: String) {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false, trimmedAnswer.isEmpty == false else { return }

        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        dataManager.saveData(cards)
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        dataManager.saveData(cards)
    }
}
