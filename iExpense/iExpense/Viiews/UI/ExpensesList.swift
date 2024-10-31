//
//  BuisenessExpensesList.swift
//  iExpense
//
//  Created by Xristos Mantsos on 31/10/24.
//

import SwiftUI

struct ExpensesList: View {
    let item: ExpenseItem
    let removeItems: (ExpenseItem) -> Void
    let archiveItem: (ExpenseItem) -> Void

    var body: some View {
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
                removeItems(item)
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
