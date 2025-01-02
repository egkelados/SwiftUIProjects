//
//  ContextMenuView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftUI

struct ContextMenuView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Blue", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .blue
                    }
                    Button("Black") {
                        backgroundColor = .black
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                }
        }
    }
}

#Preview {
    ContextMenuView()
}
