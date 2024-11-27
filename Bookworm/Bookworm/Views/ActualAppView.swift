//
//  ActualAppView.swift
//  Bookworm
//
//  Created by Xristos Mantsos on 30/9/24.
//

import SwiftData
import SwiftUI

struct ActualAppView: View {
    @Environment(\.modelContext) var modelContext
    // @Query(sort: \Book.rating, order: .reverse) var books: [Book]
    // @Query(sort: [SortDescriptor(\Book.title, order: .reverse)]) var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]

    @State private var showingAddScreen = false
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text("The title is: ") +
                                    Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .black)

                                Text("From the author: \(book.author)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .status) {
                    Button("settings", systemImage: "gearshape") {
                        showSettings.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
        .sheet(isPresented: $showingAddScreen, content: {
            AddBookView()
        })
        .alert("Koukoutza", isPresented: $showSettings) {} message: {
            Text("Settings will be added in future version!")
        }
    }

    func deleteBooks(at offsets: IndexSet) {
//        offsets.map { books[$0] }.forEach { modelContext.delete($0) }
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ActualAppView()
        .modelContainer(for: Book.self)
}
