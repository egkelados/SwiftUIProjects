//
//  EditNavigationTitleView.swift
//  Navigation
//
//  Created by Xristos Mantsos on 23/9/24.
//

import SwiftUI

struct EditNavigationTitleView: View {
    @State private var title = "SwiftUI"
    var body: some View {
        NavigationStack {
            Text("This is a navStack!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditNavigationTitleView()
}
