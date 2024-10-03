//
//  AnimationGesturesView.swift
//  Animations
//
//  Created by Xristos Mantsos on 3/10/24.
//

import SwiftUI

struct LettersAnimationView: View {
    let letters = Array("Hello SwiftUI")

    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged{ dragAmount = $0.translation}
                .onEnded({ _ in
                    dragAmount = .zero
                    enabled.toggle()
                })
        )
    }
}

struct AnimationGesturesView: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
//            .animation(.bouncy, value: dragAmount) // implicit animation approach
    }
}

#Preview {
    LettersAnimationView()
}
