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
    @State private var isGrid = true

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
            Group {
                if isGrid {
                    MissionGridView(missions: search.isEmpty ? missions : searchedMission, astronauts: astronauts)

                } else {
                    MissionListView(missions: search.isEmpty ? missions : searchedMission, astronauts: astronauts)
                }
            }
            .searchable(text: $search)
            .toolbar {
                Button {
                    isGrid.toggle()
                    print("Button pressed, showingGrid is now: \(isGrid)") // Debugging statement
                } label: {
                    Image(systemName: isGrid ? "list.bullet" : "square.grid.2x2.fill")
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
