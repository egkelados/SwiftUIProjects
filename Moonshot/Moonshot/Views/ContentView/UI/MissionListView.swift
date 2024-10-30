//
//  MissionListView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 30/10/24.
//

import SwiftUI

struct MissionListView: View {
    let missions: [Missions]
    let astronauts: [String: Astronaut]

    var body: some View {
        NavigationStack {
            List(missions, id: \.id) { mission in

                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()

                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical)
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain) // Removes default list styling
            .padding([.horizontal, .bottom])
            .toolbar {
                NavToGalleryView()
            }
        }
        .navigationTitle("Missions")
    }
}

#Preview {
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionListView(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
