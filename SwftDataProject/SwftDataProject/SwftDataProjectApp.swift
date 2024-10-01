//
//  SwftDataProjectApp.swift
//  SwftDataProject
//
//  Created by Xristos Mantsos on 1/10/24.
//
import SwiftData
import SwiftUI


@main
struct SwftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            PredicateView()
        }
        .modelContainer(for: User.self)
    }
}
