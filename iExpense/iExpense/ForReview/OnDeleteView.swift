// TODO: 1) Automatic scroll to the last row added...
// TODO: 2) Add **onMove** modifier...

// Add onMove modifier to reorder the list items...
// add scrollViewReader

import SwiftUI

struct OnDeleteView: View {
    @State private var numbers = [Int]()
    @State private var currNumber = 0

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(numbers, id: \.self) { number in
                            Text("Row \(number)")
                                .id(number)
                        }
                        .onDelete(perform: removeRows)
                        .onMove(perform: onMove)
                    }
                    .onChange(of: numbers) { _, _ in
                        if let bottom = numbers.last {
                            withAnimation {
                                proxy.scrollTo(bottom)
                            }
                        }
                    }
                    HStack {
                        
                        Button("", systemImage: "hand.point.up") {
                            if let firstItem = numbers.first {
                                withAnimation {
                                    proxy.scrollTo(firstItem) // Scroll to the first item
                                }
                            }
                        }
                        Spacer()
                        Button("Add Number") {
                            numbers.append(currNumber)
                            currNumber += 1
                        }
                        
                    }
                    .padding(.horizontal ,25)
                    .padding(.vertical ,5)
                }
            }
            .navigationTitle("Add Items...")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    if numbers.count > 1 {
                        EditButton()
                    }
                }
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }

    func onMove(indices: IndexSet, to newOffset: Int) {
        guard numbers.count > 2 else { return }
        numbers.move(fromOffsets: indices, toOffset: newOffset)
    }
}

#Preview {
    OnDeleteView()
}
