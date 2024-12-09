//
//  ContentView.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            Task {
                do {
                    try await Service().fetchData()
                } catch {
                    print("Unable to fetch the data.....\(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
