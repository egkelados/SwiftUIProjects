//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Xristos Mantsos on 12/9/24.
//

import SwiftUI

@main
struct iExpenseApp: App {
    @State private var items = Expenses()
    var body: some Scene {
        WindowGroup {
            ActualAppView()
                .environment(items)
        }
    }
}
