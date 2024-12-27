//
//  ConcChallengeApp.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import SwiftData
import SwiftUI

@main
struct ConcChallengeApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: User.self, configurations: ModelConfiguration(for: User.self))
        } catch {
            fatalError("Could not initialize the container.")
        }
    }
    var body: some Scene {
        WindowGroup {
            UsersListView()
                .modelContainer(container)
        }
    }
}
