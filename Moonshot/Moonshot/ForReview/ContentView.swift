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
            .customModifier()
    }
}

extension Image {
    func customModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/ .fill/*@END_MENU_TOKEN@*/)
            .containerRelativeFrame(.horizontal) {
                size, _ in // axis = _
                size * 0.9
            }
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
