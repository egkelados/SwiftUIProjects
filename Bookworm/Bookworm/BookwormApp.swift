//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Xristos Mantsos on 30/9/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ActualAppView()
        }
        .modelContainer(for: Book.self)
    }
}
