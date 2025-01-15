//
//  ObservableDemoView.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import SwiftUI
import Observation

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HishScoreView: View {
    @Environment(Player.self) var player

    var body: some View {
        @Bindable var player = player
        Stepper("Your high score: \(player.highScore)", value: $player.highScore)
    }
}

struct ObservableDemoView: View {
    @State private var player = Player()
    var body: some View {
        VStack {
            Text("Welcome")
            HishScoreView()
        }
        .environment(player)
    }
}

#Preview {
    ObservableDemoView()
}
