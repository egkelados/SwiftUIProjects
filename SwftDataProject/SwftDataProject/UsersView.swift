//
//  UsersView.swift
//  SwftDataProject
//
//  Created by Xristos Mantsos on 1/10/24.
//
import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                Text(user.name)
            }
        }
    }
    
    init(minimumJoinDate: Date){
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \User.name)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now)
        .modelContainer(for: User.self)
}
