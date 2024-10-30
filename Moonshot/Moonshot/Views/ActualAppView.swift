//
//  ActualAppView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 18/9/24.
//

// TODO: Launch Date Sorting:  Add the ability to sort missions by their launch dates in the ActualAppView. This can be done with a toggle button to switch between ascending and descending order

// TODO: Search Bar for Missions: Add a search bar to ActualAppView that filters the missions by name or crew member. This will give you experience working with search filtering in SwiftUI.
import SwiftUI

struct ActualAppView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Missions] = Bundle.main.decode("missions.json")
    @State private var search = ""

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var searchedMission: [Missions] {
        missions.filter { mission in
            let name = mission.displayName.lowercased().contains(search.lowercased())
            let crew = mission.crew.contains { crewMember in
                if let astronaut = astronauts[crewMember.name] {
                    return
                        astronaut.name.lowercased().contains(search.lowercased())
                } else {
                    return false
                }
            }
            return name || crew
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(search.isEmpty ? missions : searchedMission) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)

                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .searchable(text: $search)
                .padding([.horizontal, .bottom])
                
                Text("Gallery of Mission")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .padding()

                NavigationLink(destination: GalleryView()) {
                    Text("View Photos")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .background(.lightBackground)
                        .clipShape(.rect(cornerRadius: 15))
                }
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ActualAppView()
}
