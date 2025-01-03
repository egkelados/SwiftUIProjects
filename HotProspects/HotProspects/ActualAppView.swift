//
//  ActualAppView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 3/1/25.
//

import SwiftData
import SwiftUI

struct ActualAppView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Prospects.name) var prospects: [Prospects]
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem { Label("Everyone", systemImage: "person.3") }

            ProspectsView(filter: .contacted)
                .tabItem { Label("Contacted", systemImage: "checkmark.circle") }

            ProspectsView(filter: .uncontacted)
                .tabItem { Label("Uncontacted", systemImage: "questionmark.diamond") }

            MeView()
                .tabItem { Label("Me", systemImage: "person.crop.square") }
        }
    }
}

#Preview {
    ActualAppView()
        .modelContainer(for: Prospects.self)
}
