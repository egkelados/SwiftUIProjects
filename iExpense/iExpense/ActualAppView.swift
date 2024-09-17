// MARK: Save and load Data in a clean way:

/// 1. The Codable protocol, which will allow us to archive all the existing expense items ready to be stored.
/// 2.UserDefaults, which will let us save and load that archived data.
/// 3.A custom initializer for the Expenses class, so that when we make an instance of it we load any saved data from UserDefaults
/// 4.A didSet property observer on the items property of Expenses, so that whenever an item gets added or removed we’ll write out changes.

// TODO: Apply removeItems function to the List!
// TODO: Find out where UserDefaults save Data..?
// TODO: Add the ability to edit existing expense items; Add an edit feature so users can modify the name, type, or amount of an existing expense item by tapping on a row..?
// TODO: Implement swipe actions for archiving expenses;Add a swipe gesture to allow users to "archive" an expense item, which could move it to another list or section (e.g., "Archived Expenses")..?
// TODO: Group expenses by type (Personal or Business) in separate sections; Use SwiftUI's Section view to group the expenses by their type, organizing the list more cleanly..?
// TODO: Add a searchbar to filter expenses by name; Implement a search feature that allows users to quickly find a specific expense by name using SwiftUI’s Searchable modifier..?
// TODO: Display a summary of total expenses at the top of the list; Add a section at the top of the list that dynamically displays the total amount of all expenses, updating automatically as new items are added or removed..?

import SwiftUI

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
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodeItems
                return
            }
        }
        items = []
    }
}

struct ActualAppView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var user = UserDefaults.standard

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)

                            Text(item.type)
                        }

                        Spacer()

                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ActualAppView()
}
