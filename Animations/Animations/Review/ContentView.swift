//
//  ContentView.swift
//  Animations
//
//  Created by Xristos Mantsos on 11/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        print(animationAmount)

        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1 ... 10)

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }

        //        VStack {
//            Button("Tap me") {
//                animationAmount += 1
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(.circle)
//            .scaleEffect(animationAmount)
//            .blur(radius: (animationAmount - 1) * 3)
//            .animation(.spring(duration: 1, bounce: 0.5), value: animationAmount)
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
