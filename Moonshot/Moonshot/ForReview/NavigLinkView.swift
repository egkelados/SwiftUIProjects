//
//  NavigLinkView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

// TODO: Add a custom back button: Add a custom back button to the detail view instead of using the default back navigation.

// TODO: Display a dynamic detail view: Display more detailed information or style for each row in the destination view, such as images, or dynamic data related to the row.

import SwiftUI

struct NavigLinkView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 1000) { row in
                NavigationLink("Row \(row)") {
                    DetailView(row: row)
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    let row: Int
    var body: some View {
        ZStack {
            ContentView()

            VStack {
                
                Text("This is the item number : \(row)")
                    .font(.title.bold())
                Spacer()
                    .frame(height: CGFloat(row))
            }
        }
        .navigationTitle("Detail")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back", systemImage: "arrowshape.backward.fill") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigLinkView()
}
