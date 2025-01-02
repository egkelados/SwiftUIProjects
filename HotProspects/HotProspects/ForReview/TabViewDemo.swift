//
//  TabViewDemo.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftUI

struct TabViewDemo: View {
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
                .tabItem { Label("One", systemImage: "star") }
                .tag("One")
            
            
            Text("Tab 2")
                .tabItem { Label("One", systemImage: "circle") }
                .tag("Two")
        }
    }
}

#Preview {
    TabViewDemo()
}