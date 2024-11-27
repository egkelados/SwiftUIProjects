//
//  ConfirmationDialogView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 27/11/24.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @State private var dialog = false
    @State private var backgroundColor = Color.white

    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("Show Dialog") {
                dialog.toggle()
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
        }
        .confirmationDialog("Change Background", isPresented: $dialog, titleVisibility: .visible) {
            Button("Red") { backgroundColor = .red }
            Button("Blue") { backgroundColor = .blue }
            Button("Green") { backgroundColor = .green }
        } message: {
            Text("Select a new color.")
        }
    }
}

#Preview {
    ConfirmationDialogView()
}
