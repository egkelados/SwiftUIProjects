//
//  ArchivedItemsView.swift
//  iExpense
//
//  Created by Xristos Mantsos on 17/10/24.
//

import SwiftUI

struct ArchivedItemsView: View {
    var expenses: Expenses
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.archivedItems, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(item.type)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                .onDelete(perform: removeArchivedItems)
                
            }
            .navigationTitle("Archived Expenses")
            .toolbar {
                if !expenses.items.isEmpty{
                    EditButton()
                }
            }
            
        }
    }
    func removeArchivedItems(at offsets: IndexSet) {
          expenses.archivedItems.remove(atOffsets: offsets)
      }
}

// #Preview {
//    ArchivedItemsView(expenses: Expenses())
// }
