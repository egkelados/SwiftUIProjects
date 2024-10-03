//
//  CustomizingAnimationView.swift
//  Animations
//
//  Created by Xristos Mantsos on 3/10/24.
//

import SwiftUI

struct ButtonFadeOutView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
//             animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(.easeOut(duration: 2)
                    .repeatForever(autoreverses: false),
                    value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }
    }
    
}

#Preview {
    ButtonFadeOutView()
}
