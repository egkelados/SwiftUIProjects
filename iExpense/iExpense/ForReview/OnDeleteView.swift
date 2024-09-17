//
//  OnDeleteView.swift
//  iExpense
//
//  Created by Xristos Mantsos on 13/9/24.
//


//TODO: 1) Automatic scroll to the last row added...
//TODO: 2) Add **onMove** modifier...


import SwiftUI

struct OnDeleteView: View {
    @State private var numbers = [Int]()
    @State private var currNumber = 1
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    /// Here, we pass a reference to the function. When the delete action is performed, the function will be called later.
                    .onDelete(perform: removeRows)
                    /// removeRows() : This immediately calls the removeRows() function and passes its 'return value'.
                }

                Button("Add Number") {
                    numbers.append(currNumber)
                    currNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    OnDeleteView()
}
