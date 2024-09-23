//
//  NavBarAppearenceView.swift
//  Navigation
//
//  Created by Xristos Mantsos on 23/9/24.
//

import SwiftUI

struct NavBarAppearenceView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) {i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarColorScheme(.dark)
            .toolbar(.hidden, for: .tabBar)
        }
        
    }
}

#Preview {
    NavBarAppearenceView()
}
