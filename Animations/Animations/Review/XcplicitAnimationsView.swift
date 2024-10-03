//
//  XcplicitAnimationsView.swift
//  Animations
//
//  Created by Xristos Mantsos on 3/10/24.
//

import SwiftUI

struct XcplicitAnimationsView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.9)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount),
                          axis: (x: 0.5, y: 0.1, z: 0))
    }
}

#Preview {
    XcplicitAnimationsView()
}
