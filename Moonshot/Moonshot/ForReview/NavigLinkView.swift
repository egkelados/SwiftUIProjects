//
//  NavigLinkView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

import SwiftUI

struct NavigLinkView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    NavigLinkView()
}
