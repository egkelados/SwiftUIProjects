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
                ForEach(expenses.archivedItems) { item in

                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)

                            Text(item.type)
                        }

                        Spacer()
                        ColorText(itemsAmount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
    }

    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
        dismiss()
    }
}

//#Preview {
//    ArchivedItemsView(expenses: Expenses())
//}
