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
    var currPhoto: Data?
    var inputName = ""
    var showInputName = false

    @MainActor
    func addPhoto(from pickerItems: [PhotosPickerItem], to context: ModelContext) async {
        do {
            for item in pickerItems {
                if let loadedImage = try await item.loadTransferable(type: Data.self) {
                    currPhoto = loadedImage
                    showInputName.toggle()
                }
            }
            try context.save()
        } catch {
            print("Failed to save photos !")
        }
    }
}
