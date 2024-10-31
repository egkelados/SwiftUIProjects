//
//  ExpensesVM.swift
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
            calculateTotal()
        }
    }

    var totalAmount: Double = 0.0

    func calculateTotal() {
        totalAmount = items.reduce(0) { $0 + $1.amount }
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

    // MARK: - Helper methods

    func removeItemsFromList(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func removeItems(for item: ExpenseItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }

    func archiveItem(_ item: ExpenseItem) {
        // Remove from items and add to archivedItems
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
            archivedItems.append(item)
        }
    }

    // MARK: - filter methods

    func filteredExpenses(ofType: String, searchText: String) -> [ExpenseItem] {
        items.filter { $0.type == ofType && (searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)) }
    }

}
