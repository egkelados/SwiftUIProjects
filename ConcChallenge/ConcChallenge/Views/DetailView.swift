//
//  DetailView.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) private var context
    private let user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.headline)
                    Text(user.about)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Company")
                        .font(.headline)
                    Text(user.company)
                        .font(.body)

                    Text("Email")
                        .font(.headline)
                    Text(user.email)
                        .font(.body)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Registered")
                        .font(.headline)
                    Text(formattedDate(user.registered))
                        .font(.body)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Friends")
                        .font(.headline)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(user.friends, id: \.id) { friend in
                                VStack {
                                    Text(friend.name)
                                        .font(.body)
                                        .padding()
                                        .frame(width: 100, height: 100)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle(user.name)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short 
        return formatter.string(from: date)
    }
}

#Preview {
    let container = try! ModelContainer(for: User.self, Friend.self)
    let context = container.mainContext
    let friend1 = Friend(id: "f1", name: "Alice")
    let friend2 = Friend(id: "f2", name: "Bob")

    let user = User(
        id: "1",
        name: "John Doe",
        company: "TechCorp",
        email: "john.doe@example.com",
        about: "John is a software engineer.",
        isActive: true,
        registered: ISO8601DateFormatter().date(from: "2023-11-15T05:42:00Z") ?? Date(),
        friends: [friend1, friend2]
    )

    context.insert(user)

    return DetailView(user: user)
        .modelContainer(container)
        .preferredColorScheme(.light)
}
