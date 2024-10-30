//
//  MissionView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 18/9/24.
//

// TODO: Crew Member Detail Sheet:  Add a .sheet that pops up when you long-press on a crew member's image in the MissionView. This sheet could show more detailed information about the astronaut, such as additional mission stats. done

// TODO: Mission Gallery In the MissionView, add a gallery of mission-related images at the bottom, where users can scroll through related images of the mission (even just placeholder images for now).

import SwiftUI

struct MissionView: View {
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

                HStack {
                    Text("\(mission.formattedLaunchDate)")
                        .font(.headline.bold())
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                    Spacer()
                }
                .padding(.bottom)

                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    DividerView()

                    Text(mission.description)

                    DividerView()

                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)

                CrewScrollView(crewMemberDetails: $crewMemberDetails, crew: crew)
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
    return MissionView(mission: missions[3], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
