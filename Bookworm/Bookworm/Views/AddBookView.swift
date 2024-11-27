//
//  AddBookView.swift
//  Bookworm
//
//  Created by Xristos Mantsos on 30/9/24.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var isReview = false
    
    private var isValid: Bool {
        return !title.isEmpty && !author.isEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                Section("Write a Review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0 ..< 8) {
//                            Text("\($0)")
//                        }
//                    }
                }
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        if !review.isEmpty {
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            isReview.toggle()
                        }
                    }
                    .disabled(!isValid)
                }
            }
            
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("You forgot to review the book", isPresented: $isReview) {
            Button("OK", role: .cancel) {}
            Button("Cancel", role: .destructive) {
                let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                modelContext.insert(newBook)
                dismiss()
            }
        } message: {
            Text("Tap cancel to add a review!")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        
        return AddBookView()
            .modelContainer(container)
    } catch {
        return Text("Error displaying the preview!")
    }
}
