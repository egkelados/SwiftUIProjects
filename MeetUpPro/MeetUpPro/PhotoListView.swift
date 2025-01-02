//
//  ContentView.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct PhotoListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Query(sort: \DataMeet.name) private var images: [DataMeet]
    @State private var pickerItems = [PhotosPickerItem]()

    @State private var vm = MainViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if images.isEmpty {
                    ContentUnavailableView {
                        Label("Add new Photos", systemImage: "photo.artframe")
                    } description: {
                        Text("You do not have any photos yet")
                    } actions: {
                        PhotosPicker(selection: $pickerItems, maxSelectionCount: 1, matching: .images) {
                            Label("Select a picture", systemImage: "photo")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                else {
                    List {
                        ForEach(images, id: \.self) { img in
                            NavigationLink(value: img) {
                                HStack(spacing: 15) {
                                    if let uiImage = UIImage(data: img.image) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                    }

                                    Text(img.name)
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            for index in indexSet {
                                let delImage = images[index]
                                context.delete(delImage)
                            }
                        })
                    }
                }
            }
            .navigationDestination(for: DataMeet.self) { img in
                DetailView(img: img)
            }
            .onChange(of: pickerItems) {
                Task {
                    await vm.addPhoto(from: pickerItems, to: context)
                }
            }
            .navigationTitle("Meeting App")
            .toolbar {
                if !images.isEmpty {
                    ToolbarItem(placement: .automatic) {
                        PhotosPicker(selection: $pickerItems, maxSelectionCount: 1, matching: .images) {
                            Label("Select a picture", systemImage: "plus")
                        }
                    }
                }
            }
            .alert("Photo Title", isPresented: $vm.showInputName, actions: {
                TextField("Name the photo", text: $vm.inputName)
                    .foregroundColor(colorScheme == .dark ? .white : .black)

                Button("Save") {
                    if let photo = vm.currPhoto {
                        let newImage = DataMeet(image: photo, name: vm.inputName)
                        context.insert(newImage)
                        vm.currPhoto = nil
                        vm.inputName = ""
                    }
                }
                .disabled(vm.inputName.isEmpty)
            })
        }
    }
}

#Preview {
    PhotoListView()
        .modelContainer(for: [DataMeet.self])
//        .preferredColorScheme(.dark)
}
