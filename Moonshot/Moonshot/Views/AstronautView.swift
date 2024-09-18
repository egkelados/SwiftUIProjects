//
//  AstronautView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 18/9/24.
//

//TODO: Add an animation to the astronaut's image when AstronautView appears, such as a fade or scale effect.

//TODO: Add a "More Info" button below the astronaut description that opens a web page with more details about the astronaut.
import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
