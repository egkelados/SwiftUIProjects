//
//  ContentView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

// TODO: Create a custom modifier for the image...?

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(.mood)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) {
                size, axis in // axis = _
                size * 0.9
            }
    }
}

#Preview {
    ContentView()
}
