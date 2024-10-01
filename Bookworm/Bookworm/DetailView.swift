//
//  DetailView.swift
//  Bookworm
//
//  Created by Xristos Mantsos on 1/10/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -10)
            }

            VStack {
                Text(book.author)
                    .font(.title)
                    .foregroundStyle(.secondary)

                Text(book.review)
                    .padding()

                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do { // A temporary saved object in memory
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Trivizas", genre: "Kids", review: "just a review", rating: 2)

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
