//
//  AddFormView.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import SwiftUI

struct AddFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var habbit = "as"
    @State private var category = "as"
    @State private var description = "as"

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Habbit Details")) {
                        TextField("Add Habbit", text: $habbit)
                        TextField("Add Category", text: $category)
                        TextField("Add Description", text: $description)
                    }
                }
                .frame(height: 450)
                Spacer()
                Button("Save") {
                    dismiss()
                }
                .padding()
                .frame(width: 150)
                .background(habbit.isEmpty || category.isEmpty ? Color.gray : Color.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 15))
                .disabled(habbit.isEmpty || category.isEmpty) // Disable if required fields are empty
                Spacer()
            }
            .navigationTitle("Add Habbit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddFormView()
        .preferredColorScheme(.dark)
}
