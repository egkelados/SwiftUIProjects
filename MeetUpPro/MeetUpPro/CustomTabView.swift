//
//  TabView.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import SwiftData
import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            PhotoListView() // Your main photo list view
                .tabItem {
                    Label("Photos", systemImage: "photo")
                }

            SettingsView() // A placeholder for another tab, e.g., settings
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
            
            MapPplView() // A placeholder for another tab, e.g., settings
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    CustomTabView()
        .modelContainer(for: [DataMeet.self])
}
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Text("Settings will go here!")
                .font(.title)
                .padding()
                .navigationTitle("Settings")
        }
    }
}

struct MapPplView: View {
    var body: some View {
        NavigationStack {
            Text("Map will go here!")
                .font(.title)
                .padding()
                .navigationTitle("Map")
        }
    }
}
