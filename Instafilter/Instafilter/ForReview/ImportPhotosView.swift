//
//  ImportPhotosView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 29/11/24.
//

import PhotosUI
import SwiftUI

struct ImportPhotosView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()

    var body: some View {
        VStack {
//            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)]))
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .images) {
                Label("Select a picture", systemImage: "photo")
            }

            ScrollView {
                ForEach(0 ..< selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
//                selectedImages.removeAll()
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    ImportPhotosView()
}
