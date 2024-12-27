//
//  MainViewModel.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import Foundation
import Observation
import PhotosUI
import SwiftData
import SwiftUI

@Observable
class MainViewModel {
    @MainActor
    func addPhoto(from pickerItems: [PhotosPickerItem], photoName: String, to context: ModelContext) async {
        do {
            for item in pickerItems {
                if let loadedImage = try await item.loadTransferable(type: Data.self) {
                    let newPhoto = DataMeet(image: loadedImage, name: photoName)
                    context.insert(newPhoto)
                }
            }
            try context.save()
        } catch {
            print("Failed to save photos !")
        }
    }
}
