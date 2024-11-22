//
//  ContentView.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.editMode) private var editMode
    @State var vm = HabbitListViewModel()
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.habbits, id: \.title) { habbit in
                    VStack(alignment: .leading) {
                        NavigationLink(habbit.title) { DetailsView(habbit: habbit, vm: vm) }

                        HStack {
                            Text(habbit.category.capitalized)
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Spacer()

                            Text("Count: \(habbit.count)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: vm.deleteHabbit)
            }
            .navigationTitle("My Habbits")
            .listStyle(.grouped)
            .overlay { NoHabbitsView(vm: vm) }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add", systemImage: "add") {
                        showAddSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddFormView(vm: vm)
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

struct NoHabbitsView: View {
    let vm: HabbitListViewModel
    var body: some View {
        Group {
            if vm.habbits.isEmpty {
                ContentUnavailableView(label: {
                    Label("No habits", systemImage: "list.bullet")
                }, description: {
                    Text("Add habits to see your list of habits...")
                }, actions: {})
            }
        }
    }
}
