//
//  AbsolutePositioningView.swift
//  LayoutAndGeometry
//
//  Created by Xristos Mantsos on 13/1/25.
//

import SwiftUI

struct AbsolutePositioningView: View {
    var body: some View {
        Text("Hello, World!")
            .background(.red)
            .offset(x: 100, y: 100)
    }
}

#Preview {
    AbsolutePositioningView()
}
