//
//  AccesibilityStandardView.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 8/1/25.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct AccesibilityStandardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency
    
    @State private var scale = 1.0
    var body: some View {
        HStack {
            if accessibilityDifferentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(accessibilityDifferentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)

        Button("Hello") {
            if accessibilityReduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }
        }
        .padding()
        .scaleEffect(scale)
        
        Text("Hello Transparency")
            .padding()
            .background(accessibilityReduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    AccesibilityStandardView()
}
