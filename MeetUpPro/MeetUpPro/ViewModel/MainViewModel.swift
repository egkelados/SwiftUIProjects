//
//  MainViewModel.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable
class MainViewModel {
    private let fileName = "dataMeet.json"
    var dataMeets: [DataMeet] = []

    func getFileUrl() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first?.appendingPathComponent(fileName)
    }

    func saveData() {
        guard let fileURL = getFileUrl() else { return }
        do {
            let data = try JSONEncoder().encode(dataMeets)
            try data.write(to: fileURL)
        } catch {
            print("Failed Saving Data \(error.localizedDescription)")
        }
    }

    func loadDataFromJson() {
        guard let fileURL = getFileUrl(), FileManager.default.fileExists(atPath: fileURL.path(percentEncoded: true)) else {
            print("JSON file does not exist.")
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            dataMeets = try JSONDecoder().decode([DataMeet].self, from: data)
            print("Data loaded successfully: \(dataMeets)")
        } catch {
            print("Failed to load Data \(error.localizedDescription)")
        }
    }

    func addPhoto(image: Data, name: String) {
        let newPhoto = DataMeet(image: image, name: name)
        dataMeets.append(newPhoto)
        saveData()
    }

    func deletePhoto(at offSets: IndexSet) {
        dataMeets.remove(atOffsets: offSets)
        saveData()
    }
}
