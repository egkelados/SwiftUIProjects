// MARK: Save and load Data in a clean way:

/// 1. The Codable protocol, which will allow us to archive all the existing expense items ready to be stored.
/// 2.UserDefaults, which will let us save and load that archived data.
/// 3.A custom initializer for the Expenses class, so that when we make an instance of it we load any saved data from UserDefaults
/// 4.A didSet property observer on the items property of Expenses, so that whenever an item gets added or removed we’ll write out changes.

// TODO: Apply removeItems function to the List!
// This modifier applies on ForEach!!
// TODO: Find out where UserDefaults save Data..?
// Done
// TODO: Add the ability to edit existing expense items; Add an edit feature so users can modify the name, type, or amount of an existing expense item by tapping on a row..?
// add one more toolbaritem...
// TODO: Implement swipe actions for archiving expenses;Add a swipe gesture to allow users to "archive" an expense item, which could move it to another list or section (e.g., "Archived Expenses")..?

// TODO: Group expenses by type (Personal or Business) in separate sections; Use SwiftUI's Section view to group the expenses by their type, organizing the list more cleanly..?
// add seperate section and filter items by type...
// TODO: Add a searchbar to filter expenses by name; Implement a search feature that allows users to quickly find a specific expense by name using SwiftUI’s Searchable modifier..?

// TODO: Display a summary of total expenses at the top of the list; Add a section at the top of the list that dynamically displays the total amount of all expenses, updating automatically as new items are added or removed..?

import SwiftUI

// MARK: - Custom View for amount colors

struct ColorText: View {
    let itemsAmount: Double

    var body: some View {
        if itemsAmount < 10 {
            Text(itemsAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.green)
        } else if itemsAmount > 10 && itemsAmount < 100 {
            Text(itemsAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.blue)
        } else {
            Text(itemsAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.red)
        }
    }
}

struct ActualAppView: View {
    @Environment(Expenses.self) private var expenses
    @State private var showingAddExpense = false
    @State private var user = UserDefaults.standard
    @State private var searchText = ""
    @State private var isArchive = false

    var body: some View {
        NavigationStack {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }, id: \.id) { item in

                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)

                                Text(item.type)
                            }

                            Spacer()
                            ColorText(itemsAmount: item.amount)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                removeItems(for: item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            Button {
                                archiveItem(item)
                            } label: {
                                Label("Archive", systemImage: "archivebox")
                            }
                            .tint(.blue) // Optional: customize swipe button color
                        }
                    }
                }

                Section("Buiseness Expenses") {
                    ForEach(expenses.items.filter { $0.type == "Buiseness" }, id: \.id) { item in

                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)

                                Text(item.type)
                            }

                            Spacer()
                            ColorText(itemsAmount: item.amount)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                removeItems(for: item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            Button {
                                archiveItem(item)
                            } label: {
                                Label("Archive", systemImage: "archivebox")
                            }
                            .tint(.blue) // Optional: customize swipe button color
                        }
                    }
                }
            }

            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Archive") {
                        isArchive.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .sheet(isPresented: $isArchive) {
                ArchivedItemsView(expenses: expenses)
            }
        }
        .searchable(text: $searchText)
        .onAppear {
            // print the path of the .plist!
            if let libraryPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
                print("Library directory path: \(libraryPath.path)")
            }
        }
    }

    func removeItems(for item: ExpenseItem) {
        if let index = expenses.items.firstIndex(where: { $0.id == item.id }) {
            expenses.items.remove(at: index)
        }
    }

    func archiveItem(_ item: ExpenseItem) {
        // Remove from items and add to archivedItems
        if let index = expenses.items.firstIndex(where: { $0.id == item.id }) {
            expenses.items.remove(at: index)
            expenses.archivedItems.append(item)
        }
    }
}

#Preview {
    ActualAppView()
}
