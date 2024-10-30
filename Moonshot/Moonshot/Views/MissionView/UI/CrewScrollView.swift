//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 30/10/24.
//

import SwiftUI

struct CrewScrollView: View {
    @Binding var crewMemberDetails: CrewMember?

    let crew: [CrewMember]
    var body: some View {
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
}

#Preview {
    // Load missions and astronauts for the preview
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    // Create sample crew for the preview
    let sampleMission = missions[3] // Choose a mission for the preview
    let crew: [CrewMember] = sampleMission.crew.compactMap { member in
        if let astronaut = astronauts[member.name] {
            return CrewMember(role: member.role, astronaut: astronaut)
        }
        return nil
    }
    
    // Create a state variable for crewMemberDetails
    @State var crewMemberDetails: CrewMember?

    // Return the CrewScrollView with the sample crew
    return CrewScrollView(crewMemberDetails: $crewMemberDetails, crew: crew)
        .preferredColorScheme(.dark)
}
