//
//  PromptsWithOptionalsView.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct PromptsWithOptionalsView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    var body: some View {
        VStack(spacing: 15) {
            Button("Show sheet") {
                selectedUser = User()
            }

            Button("Show alert") {
                selectedUser = User()
                isShowingUser.toggle()
            }
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Text(user.id)
            Button("Cancel", role: .cancel) {}
        }
        .sheet(item: $selectedUser) { user in
            
            Text(user.id)
                .presentationDetents([.fraction(0.25), .large])
        }
    }
}

#Preview {
    PromptsWithOptionalsView()
}
