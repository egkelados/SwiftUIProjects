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
    @Query(sort: \DataMeet.name) private var images: [DataMeet]
    @State private var pickerItems = [PhotosPickerItem]()
    let vm = MainViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if images.isEmpty {
                    ContentUnavailableView {
                        Label("Add new Photos", systemImage: "photo.artframe")
                    } description: {
                        Text("You do not have any photos yet")
                    } actions: {
                        PhotosPicker(selection: $pickerItems, maxSelectionCount: 2, matching: .images) {
                            Label("Select a picture", systemImage: "photo")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                else {
                    List {
                        ForEach(images, id: \.self) { img in
                            NavigationLink(value: img) {
                                HStack {
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
                            .navigationDestination(for: DataMeet.self) { data in
                                EmptyView()
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
            .onChange(of: pickerItems) {
                Task {
                    await vm.addPhoto(from: pickerItems, photoName: "as", to: context)
                }
            }
            .navigationTitle("Meeting App")
        }
    }
}

#Preview {
    PhotoListView()
        .modelContainer(for: [DataMeet.self])
        .preferredColorScheme(.dark)
}
