//
//  UsersListView.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import SwiftData
import SwiftUI

struct UsersListView: View {
    @Environment(\.modelContext) private var context
    private var vm = ViewModel()
    @Query(sort: \User.name, order: .forward) var users: [User]

    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name)
                            .font(.title3)
                        Spacer()
                        Text(user.isActive ? "Online" : "Offline")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
        }
        .task {
            if users.isEmpty {
                await vm.populateUsers(context: context)
            }
        }
    }
}

#Preview {
    return UsersListView()
        .modelContainer(for: [User.self])
        .preferredColorScheme(.dark)
}
