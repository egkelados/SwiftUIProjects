//
//  ScrollingDataView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

// TODO: Add the image as background for this View..?

import SwiftUI

// MARK: Custom text
struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(text: String) {
        print("Creating a new CustomText...")
        self.text = text
    }
}

// MARK: Scroll view
struct ScrollingDataView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0 ..< 100) {
                    CustomText(text: "Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ScrollingDataView()
}
