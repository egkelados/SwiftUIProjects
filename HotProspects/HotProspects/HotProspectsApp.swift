//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ActualAppView()
        }
        .modelContainer(for: Prospects.self)
    }
}
