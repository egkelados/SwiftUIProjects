//
//  ControlAnimationStackView.swift
//  Animations
//
//  Created by Xristos Mantsos on 3/10/24.
//

import SwiftUI

struct ControlAnimationStackView: View {
    @State private var enabled = false
    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .red : .blue)
        .foregroundStyle(.white)
//        .animation(nil, value: enabled)
        .animation(.default, value: enabled)
        .clipShape(.rect(cornerRadius: enabled ? 50 : 0))
        .animation(.spring(duration: 1, bounce: 0.9), value: enabled)


    }
}

#Preview {
    ControlAnimationStackView()
}
