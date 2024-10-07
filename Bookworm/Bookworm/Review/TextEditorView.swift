//
//  TextEditorView.swift
//  Bookworm
//
//  Created by Xristos Mantsos on 30/9/24.
//

import SwiftUI

struct TextEditorView: View {
    @AppStorage("notesE") private var notesEditor = ""
    @AppStorage("notesT") private var notesTextField = ""
    var body: some View {
        NavigationStack {
            TextField("Enter your text",text: $notesTextField, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
            
            
            TextField("Enter your text",text: $notesEditor, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    TextEditorView()
}
