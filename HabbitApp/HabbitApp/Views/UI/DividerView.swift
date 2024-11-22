//
//  DividerView.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 22/11/24.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 3)
            .foregroundStyle(.gray.opacity(0.8))
            .padding(.vertical)
    }
}

#Preview {
    DividerView()
}
