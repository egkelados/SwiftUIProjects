//
//  AddFormView.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import SwiftUI

struct AddFormView: View {
    @Environment(\.dismiss) private var dismiss
    let vm: HabbitViewModel
    @State private var title = ""
    @State private var category: Categories = .gym
    @State private var description = ""

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Habbit Details")) {
                        TextField("Add Title", text: $title)
                        Picker("Select category", selection: $category) {
                            ForEach(Categories.allCases, id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)

                        TextField("Add Description", text: $description)
                    }
                }
                .frame(height: 450)
                Spacer()
                Button("Save") {
                    let habbit = Habbits(title: title, category: category, description: description)
                    vm.save(habbit: habbit)
                    dismiss()
                }
                .padding()
                .frame(width: 150)
                .background(title.isEmpty ? Color.gray : Color.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 15))
                .disabled(title.isEmpty) // Disable if required fields are empty
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
    AddFormView(vm: HabbitViewModel())
        .preferredColorScheme(.dark)
}
