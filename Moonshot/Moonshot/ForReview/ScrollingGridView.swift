//
//  ScrollingGridView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

//TODO: Add dynamic item content: Replace the placeholder text "Item \($0)" with dynamic content, such as images or custom views, to make the grid more engaging.

//TODO: Implement item selection: Add functionality to handle item selection, such as changing the background color or showing a detail view when an item is tapped.

import SwiftUI

struct ScrollingGridView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
//        GridItem(.fixed(80))
    ]
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: layout) {
                ForEach(0 ..< 1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

#Preview {
    ScrollingGridView()
}
