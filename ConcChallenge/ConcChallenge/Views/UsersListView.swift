//
//  UsersListView.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import SwiftUI

struct UsersListView: View {
    private var vm = ViewModel()

    var body: some View {
        NavigationStack {
            List(vm.users, id: \.id) { user in
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
            if vm.users.isEmpty {
                await vm.populateUsers()
            }
        }
    }
}

#Preview {
    UsersListView()
        .preferredColorScheme(.dark)
}
