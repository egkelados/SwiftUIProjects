//
//  ContentUnavailableDemoView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 27/11/24.
//

import SwiftUI

struct ContentUnavailableDemoView: View {
    @State private var notes = "changes"
    var body: some View {
        if notes.isEmpty {
            ContentUnavailableView("No snippets", systemImage: "swift", description: Text("You do not have any saved snippets yet"))
        } else {
            ContentUnavailableView {
                Label("No snippets", systemImage: "swift")
            } description: {
                Text("You do not have any saved snippets yet")
            } actions: {
                Button("Create a snippet") {
                    // create a snippet
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentUnavailableDemoView()
}
