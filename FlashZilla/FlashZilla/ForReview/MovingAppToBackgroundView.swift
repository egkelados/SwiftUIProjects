//
//  MovingAppToBackgroundView.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 8/1/25.
//

import SwiftUI

struct MovingAppToBackgroundView: View {
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { oldValue, newValue in
                if newValue == .active {
                    print("Active")
                } else if newValue == .inactive {
                    print("Inactive")
                } else if newValue == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    MovingAppToBackgroundView()
}
