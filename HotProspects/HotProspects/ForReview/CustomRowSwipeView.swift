//
//  CustomRowSwipeView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftUI

struct CustomRowSwipeView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Hi")
                    }
                    .tint(.orange)
                }
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Delete")
                    }
                    
                }
        }
    }
}

#Preview {
    CustomRowSwipeView()
}
