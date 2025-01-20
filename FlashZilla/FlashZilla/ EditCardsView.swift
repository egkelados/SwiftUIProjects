//
//   EditCardsView.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 11/1/25.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var vm = EditCardViewModel()
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card"){
                        vm.addCard(newPrompt, newAnswer)
                        newPrompt = ""
                        newAnswer = ""
                    }
                }

                Section {
                    ForEach(0 ..< vm.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(vm.cards[index].prompt)
                                .font(.headline)
                            Text(vm.cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: vm.removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") {
                    vm.done()
                    dismiss()
                }
            }
            .onAppear(perform: vm.loadData)
        }
    }
}

#Preview {
    EditCardsView(vm : EditCardViewModel())
}
