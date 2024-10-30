//
//  AstronautView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 18/9/24.
//

// TODO: Add an animation to the astronaut's image when AstronautView appears, such as a fade or scale effect.

// TODO: Add a "More Info" button below the astronaut description that opens a web page with more details about the astronaut.
import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    @State private var animationOpacity = 0.0
    @State private var animationScale = 0.4

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .opacity(animationOpacity)
                    .scaleEffect(animationScale)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.2).delay(0.2)) {
                            animationOpacity = 1.0
                        }
                        withAnimation(.easeOut(duration: 1.2).delay(0.4)) {
                            animationScale = 1.0
                        }
                    }

                Text(astronaut.description)
                    .padding()

                Button {
                    openMoreInfo()
                } label: {
                    Text("More info")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.lightBackground)
                        .clipShape(.rect(cornerRadius: 25))
                }
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func openMoreInfo() {
        if let url = URL(string: "https://en.wikipedia.org/wiki/\(astronaut.name)") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
