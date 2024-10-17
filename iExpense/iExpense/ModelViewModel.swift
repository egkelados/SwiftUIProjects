//
//  ModelViewModel.swift
//  iExpense
//
//  Created by Xristos Mantsos on 17/10/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            saveItems()
        }
    }

    var archivedItems = [ExpenseItem]() {
        didSet {
            saveArchivedItems()
        }
    }

    init() {
        loadItems()
        loadArchivedItems()
    }

    // Save regular expenses
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }

    // Save archived expenses
    private func saveArchivedItems() {
        if let encoded = try? JSONEncoder().encode(archivedItems) {
            UserDefaults.standard.set(encoded, forKey: "ArchivedItems")
        }
    }

    // Load regular expenses from UserDefaults
    private func loadItems() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
            }
        }
    }

    // Load archived expenses from UserDefaults
    private func loadArchivedItems() {
        if let savedArchivedItems = UserDefaults.standard.data(forKey: "ArchivedItems") {
            if let decodedArchivedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedArchivedItems) {
                archivedItems = decodedArchivedItems
            }
        }
    }
}
