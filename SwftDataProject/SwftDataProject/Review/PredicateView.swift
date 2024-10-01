//
//  PredicateView.swift
//  SwftDataProject
//
//  Created by Xristos Mantsos on 1/10/24.
//
import SwiftData
import SwiftUI

struct PredicateView: View {
    @Environment(\.modelContext) var modelContext

    @Query(filter: #Predicate<User> { user in
        if user.name.localizedStandardContains("R") {
            if user.city == "London" {
                return true
            }
            else {
                return false
            }
            return false
        }
    }, sort: \User.name) var users: [User]

//    @Query(sort: [
//        SortDescriptor(\User.joinDate),
//        SortDescriptor(\User.name)
//    ]) var users: [User]

    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button("Add user", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)

                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    PredicateView()
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//
//        let example = User(name: "Captain", city: "Plcity", joinDate: .now)
//        let example1 = User(name: "Princess", city: "Golden City", joinDate: .now)
//        container.mainContext.insert(example)
//        container.mainContext.insert(example1)
//        return PredicateView()
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview!\(error.localizedDescription)")
//    }
}
