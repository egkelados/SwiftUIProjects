//
//  VisualEffectView.swift
//  LayoutAndGeometry
//
//  Created by Xristos Mantsos on 14/1/25.
//

import SwiftUI

struct VisualEffectView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0 ..< 1000) { index in

                    Text("Number #\(index)")
                        .font(.largeTitle)
                        .padding()
                        .background(.red)
                        .frame(width: 200, height: 200)
                        .visualEffect { content, proxy in
                            content
                                .rotation3DEffect(
                                    .degrees(-proxy.frame(in: .global).minX / 8),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                        }
                }
            }
            .border(.black)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    VisualEffectView()
}
