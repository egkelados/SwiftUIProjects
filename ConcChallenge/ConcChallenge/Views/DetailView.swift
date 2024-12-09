//
//  DetailView.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import SwiftUI

struct DetailView: View {
    private let user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(user.about)
                Text(user.company)
                Text(user.email)
                ForEach(user.friends, id: \.id) { friend in
                    Text(friend.name)
                }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle(user.name)
    }
}

#Preview {
    DetailView(user: User.example)
}
