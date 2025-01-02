//
//  ContentView.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import PhotosUI
import SwiftUI

struct PhotoListView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var currPhoto: Data?
    @State private var inputName = ""
    @State private var showInputName = false

    @State private var vm = MainViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if vm.dataMeets.isEmpty {
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
                        ForEach(vm.dataMeets, id: \.self) { img in
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
                        .onDelete(perform: vm.deletePhoto)
                    }
                }
            }
            .navigationDestination(for: DataMeet.self) { img in
                DetailView(img: img)
            }
            .onAppear {
                print("PhotoListView appeared, loading data...")
                vm.loadDataFromJson()
                print("Loaded data: \(vm.dataMeets)")
            }
            .onChange(of: pickerItems) {
                Task {
                    for item in pickerItems {
                        if let photoData = try? await item.loadTransferable(type: Data.self) {
                            currPhoto = photoData
                            print("currPhoto set: \(currPhoto != nil)")
                            showInputName = true
                        }
                    }
                }
            }
            .navigationTitle("Meeting App")
            .toolbar {
                if !vm.dataMeets.isEmpty {
                    ToolbarItem(placement: .automatic) {
                        PhotosPicker(selection: $pickerItems, maxSelectionCount: 1, matching: .images) {
                            Label("Select a picture", systemImage: "plus")
                        }
                    }
                }
            }
            .overlay(
                CustomAlertView(
                    isPresented: $showInputName, inputName: $inputName,
                    title: "Photo Title",
                    message: "Enter a name for the photo.",
                    actionTitle: "Save",
                    cancelTitle: "Cancel"
                ) {
                    guard let photo = currPhoto else { return }
                    print("Save button pressed with name: \(inputName)")
                    vm.addPhoto(image: photo, name: inputName)
                    resetStates()
                } cancelAction: {
                    resetStates()
                }
            )
        }
    }

    private func resetStates() {
        inputName = ""
        currPhoto = nil
        pickerItems.removeAll()
        showInputName = false
    }
}

#Preview {
    PhotoListView()
}
