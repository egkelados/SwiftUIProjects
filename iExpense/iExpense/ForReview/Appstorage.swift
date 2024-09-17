//
//  UserDefaultsView.swift
//  iExpense
//
//  Created by Xristos Mantsos on 13/9/24.
//

import SwiftUI

struct Appstorage: View {
    @AppStorage("tapCount") private var tapCount = 0
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            
//            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

#Preview {
    Appstorage()
}
