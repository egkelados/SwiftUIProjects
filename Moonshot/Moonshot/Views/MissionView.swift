//
//  MissionView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 18/9/24.
//

// TODO: Crew Member Detail Sheet:  Add a .sheet that pops up when you long-press on a crew member's image in the MissionView. This sheet could show more detailed information about the astronaut, such as additional mission stats.

// TODO: Mission Gallery In the MissionView, add a gallery of mission-related images at the bottom, where users can scroll through related images of the mission (even just placeholder images for now).

import SwiftUI

struct MissionView: View {
    struct CrewMember: Identifiable {
        var id = UUID()
        let role: String
        let astronaut: Astronaut
    }

    @State private var crewMemberDetails: CrewMember?

    let mission: Missions
    let crew: [CrewMember]

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.6
                    }
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Rectangle()
                        .frame(height: 3)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.vertical)

                    Text(mission.description)

                    Rectangle()
                        .frame(height: 3)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.vertical)

                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMemeber in
                            NavigationLink {
                                AstronautView(astronaut: crewMemeber.astronaut)
                            } label: {
                                HStack {
                                    Image(crewMemeber.astronaut.id)
                                        .resizable()
                                        .frame(width: 150, height: 100)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                        .onLongPressGesture(minimumDuration: 0.9, maximumDistance: 50) {
                                            crewMemberDetails = crewMemeber
                                        }
                                    VStack(alignment: .leading) {
                                        Text(crewMemeber.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)

                                        Text(crewMemeber.role)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .padding(.horizontal)
                                
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .sheet(item: $crewMemberDetails) { member in
            AstronautView(astronaut: member.astronaut)
        }
    }

    init(mission: Missions, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
