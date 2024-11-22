//
//  HabbitViewModel.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation
import Observation

@Observable
class HabbitListViewModel {
    var habbits = [HabbitViewModel]()
//    private let habbitService = HabbitService()

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
           let decoded = try? JSONDecoder().decode([HabbitViewModel].self, from: data)
        {
            habbits = decoded
        }
    }

//    func loadHabbits() {
//        habbits = habbitService.fetchHabbits()
//        saveToUserDefaults()
//    }

    func deleteHabbit(at index: IndexSet) {
        habbits.remove(atOffsets: index)
        saveToUserDefaults()
    }

    func save(habbit: HabbitViewModel) {
        habbits.append(habbit)
        saveToUserDefaults()
    }

    func incrementCount(for habbit: HabbitViewModel) {
        guard let index = habbits.firstIndex(of: habbit) else { return }
        habbits[index].habbit.count += 1
        saveToUserDefaults()        
    }
    
    func resetCounting(for habbit: HabbitViewModel) {
        guard let index = habbits.firstIndex(of: habbit) else { return }
        habbits[index].habbit.count = 0
        saveToUserDefaults()
    }
}

struct HabbitViewModel: Codable, Equatable {
    var habbit: Habbits

    var description: String {
        return habbit.description
    }

    var title: String {
        return habbit.title
    }

    var category: String {
        return habbit.category.rawValue
    }
    
    var count: Int {
        return habbit.count
    }
}
