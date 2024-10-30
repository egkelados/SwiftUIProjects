//
//  DividerView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 30/10/24.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 3)
            .foregroundStyle(.white.opacity(0.8))
            .padding(.vertical)
    }
}

#Preview {
    DividerView()
        .background(.darkBackground)
}
