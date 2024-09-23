//
//  NavigationProgrammaticView.swift
//  Navigation
//
//  Created by Xristos Mantsos on 23/9/24.
//

import SwiftUI

struct NavigationProgrammaticView: View {
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32") {
                    path = [32]
                }
                Button("Show 64") {
                    path.append(64)
                }
                Button("Show 32 the 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected: \(selection)")
            }
        }
    }
}

#Preview {
    NavigationProgrammaticView()
}
