//
//  ScrollingGridView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

// TODO: Add dynamic item content: Replace the placeholder text "Item \($0)" with dynamic content, such as images or custom views, to make the grid more engaging.

// TODO: Implement item selection: Add functionality to handle item selection, such as changing the background color or showing a detail view when an item is tapped.

import SwiftUI

struct Star: Identifiable {
    let id = UUID()
    var isSelected: Bool
}

struct ScrollingGridView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
//        GridItem(.fixed(80))
    ]
    @State private var stars: [Star] = Array(repeating: Star(isSelected: false), count: 100)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(stars.indices, id: \.self) { index in
                    VStack {
                        Image(systemName: "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)
                            .foregroundColor(stars[index].isSelected ? .cyan : .orange)
                            .onTapGesture {
                                stars[index].isSelected.toggle()
                            }
                        Text("Star \(index + 1)")
                    }
                    .padding()
                    .background(stars[index].isSelected ? Color.gray.opacity(0.1) : Color.clear)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                }
            }
        }
    }
}

#Preview {
    ScrollingGridView()
}
