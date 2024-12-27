//
//  MeetUpProApp.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import SwiftData
import SwiftUI

@main
struct MeetUpProApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: DataMeet.self, configurations: ModelConfiguration(for: DataMeet.self))
        } catch {
            fatalError("Could not initialize the container!")
        }
    }

    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .modelContainer(container)
        }
    }
}
